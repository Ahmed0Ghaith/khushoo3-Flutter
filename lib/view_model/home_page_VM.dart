import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:khushoo3/models/SalatModel.dart';
import 'package:khushoo3/models/azkarModel.dart';
import 'package:khushoo3/view/Componants/ShowToast.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:khushoo3/view_model/network/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:khushoo3/gen/assets.gen.dart';


class HomePageVM extends Cubit<BaseStates> {
  HomePageVM() : super(InitialState()){
    loadSavedLanguage();
   // registerNotification();
  }

  Locale currentLocale = const Locale('ar');

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('app_language') ?? 'ar';
    currentLocale = Locale(langCode);
    emit(const ChangeLanguageState());
  }

  Future<void> changeLanguage(String languageCode) async {
    if (currentLocale.languageCode == languageCode) return;
    currentLocale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', languageCode);
    emit(const ChangeLanguageState());
  }

   int totalNotifications=0;
  final CarouselSliderController Ccontroller = CarouselSliderController();

   int currentPage = 0;

  static HomePageVM get(context) => BlocProvider.of(context);

  int Counter = 0;
  bool CounterVisibility = false;
  bool SState = false;
  bool Isenablesearch = true;
  AudioPlayer? player;
 bool isload = false;
  Position? CurrentPosition;
  List<Map> model = [];
  Database? _database;
  String? statetext;
  final Map<String, int> prayerTimeOffsets = {
    'الفجر': 0,
    'الشروق': 0,
    'الظهر': 0,
    'العصر': 0,
    'المغرب': 0,
    'العشاء': 0,
  };
  bool _timeOffsetsLoaded = false;

  List<Azkardata>? azkarlist = [];
  List<Azkardata>? list = [];
  List<Azkardata>? filteredList = [];
  TextEditingController? controller;

  //Methods

  //CreateDataBase
  Future<void> createDatabase() async {
    try {
      _database = await openDatabase(
        'CalendarCash.db',
        version: 1,
        onCreate: (database, version) async {
          await database.execute(
            'CREATE TABLE Salattime (HDate TEXT, HMonth TEXT, Date TEXT, Salat TEXT, Time TEXT, Image TEXT)',
          );
        },
        onOpen: (database) async {
          await database.execute(
            'CREATE TABLE IF NOT EXISTS Salattime (HDate TEXT, HMonth TEXT, Date TEXT, Salat TEXT, Time TEXT, Image TEXT)',
          );
        },
      );
    } catch (e) {
      statetext = 'خطأ في تهية قاعدة البيانات المحلية';
      emit(ErrorCreateDataBaseState(e.toString()));
      rethrow;
    }
  }
//GetTodayData
  Future<void> getTodayData() async {
    isload = true;
    statetext = "تحميل بيانات الصلاة لليوم";
    emit(LodingTodayDataState());
    try {
      await _loadPrayerTimeOffsets();
      if (_database == null) await createDatabase();

      final now = DateTime.now();
      final today = DateFormat('dd-MM-yyyy').format(now);
      final monthPattern = '%-${now.month.toString().padLeft(2, '0')}-${now.year}';
      final cachedMonth = await _database!.rawQuery(
        'SELECT Date FROM Salattime WHERE Date LIKE ? LIMIT 1',
        [monthPattern],
      );
      final cachedToday = await _database!.query(
        'Salattime',
        columns: ['Date'],
        where: 'Date = ?',
        whereArgs: [today],
        limit: 1,
      );
      if (cachedMonth.isEmpty || cachedToday.isEmpty) {
        CurrentPosition = await _determinePosition();
        if (CurrentPosition == null) {
          throw StateError('تعذر تحديد الموقع لتحميل مواقيت الصلاة');
        }
        await insertinDatabase();
      }

      model = await _database!.query(
        'Salattime',
        where: 'Date = ?',
        whereArgs: [today],
        orderBy: 'rowid',
      );
      statetext = "تم تحميل البيانات";
      emit(SuccessTodayLoadingDataState());
    } catch (e) {
      statetext = "تعذر تحميل مواقيت الصلاة";
      emit(ErrorTodayLoadingDataState(e.toString()));
    } finally {
      isload = false;
    }
  }

  Future<Map<String, int>> loadPrayerTimeOffsets() async {
    await _loadPrayerTimeOffsets();
    return Map<String, int>.from(prayerTimeOffsets);
  }

  Future<void> _loadPrayerTimeOffsets() async {
    if (_timeOffsetsLoaded) return;
    final preferences = await SharedPreferences.getInstance();
    for (final prayer in prayerTimeOffsets.keys) {
      prayerTimeOffsets[prayer] =
          preferences.getInt('prayer_offset_$prayer') ?? 0;
    }
    _timeOffsetsLoaded = true;
  }

  Future<void> savePrayerTimeOffsets(Map<String, int> offsets) async {
    final preferences = await SharedPreferences.getInstance();
    for (final entry in offsets.entries) {
      if (!prayerTimeOffsets.containsKey(entry.key)) continue;
      prayerTimeOffsets[entry.key] = entry.value;
      await preferences.setInt('prayer_offset_${entry.key}', entry.value);
    }
    emit(SuccessTodayLoadingDataState());
  }

  String displayPrayerTime(Map<dynamic, dynamic> prayer) {
    final rawTime = prayer['Time']?.toString() ?? '';
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(rawTime);
    if (match == null) return rawTime.replaceAll(RegExp(r'\s*\([^)]*\)'), '');

    final hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final totalMinutes =
        (hour * 60 + minute + (prayerTimeOffsets[prayer['Salat']] ?? 0)) %
            (24 * 60);
    final adjustedHour = (totalMinutes ~/ 60).toString().padLeft(2, '0');
    final adjustedMinute = (totalMinutes % 60).toString().padLeft(2, '0');
    return '$adjustedHour:$adjustedMinute';
  }
  //DeleteDataBase
//GetDataFromApi
  Future<void> insertinDatabase() async {
     emit(LodingAPIDataState());
     statetext = "جار تحميل البيانات من الانترنت...";
     try {
       if (_database == null) await createDatabase();
       final position = CurrentPosition;
       if (position == null) {
         throw StateError('تعذر تحديد الموقع لتحميل مواقيت الصلاة');
       }
       final now = DateTime.now();
       final response = await diohelper.getData(
         url: "v1/calendar",
         query: {
           "latitude": '${position.latitude}',
           "longitude": '${position.longitude}',
           "method": "5",
           "month": '${now.month}',
           "year": '${now.year}',
         },
       );
       final calendar = SalatModel.fromJson(response.data);
       if (calendar.code != 200 || calendar.data.isEmpty) {
         throw StateError('لم يتم استلام مواقيت الصلاة من الخدمة');
       }

       await _database!.transaction((transaction) async {
         final monthPattern =
             '%-${now.month.toString().padLeft(2, '0')}-${now.year}';
         await transaction.delete(
           'Salattime',
           where: 'Date LIKE ?',
           whereArgs: [monthPattern],
         );
         final batch = transaction.batch();
         for (final day in calendar.data) {
           final date = day.date?.gregorian?.date;
           final timings = day.timings;
           if (date == null || timings == null) continue;
           final hijriDate = day.date?.hijri?.date ?? '';
           final hijriMonth = day.date?.hijri?.month?.en ?? '';
           final entries = <List<String?>>[
             [timings.fajr, 'الفجر', 'assets/images/FR.jpg'],
             [timings.sunrise, 'الشروق', 'assets/images/SR.jpg'],
             [timings.dhuhr, 'الظهر', 'assets/images/ZH.jpg'],
             [timings.asr, 'العصر', 'assets/images/AS.jpg'],
             [timings.maghrib, 'المغرب', 'assets/images/MA.jpg'],
             [timings.isha, 'العشاء', 'assets/images/isha.jpg'],
           ];
           for (final entry in entries) {
             if (entry[0] == null) continue;
             batch.insert('Salattime', {
               'HDate': hijriDate,
               'HMonth': hijriMonth,
               'Date': date,
               'Salat': entry[1],
               'Time': entry[0],
               'Image': entry[2],
             });
           }
         }
         await batch.commit(noResult: true);
       });

       statetext = "تم تحديث مواقيت هذا الشهر";
       emit(SuccessAPILoadingDataState());
       emit(SuccessUpdateDataState());
     } catch (e) {
       emit(ErrorAPILoadingDataState(e.toString()));
       rethrow;
     }
  }
//LocationData
  Future<Position?> ? _determinePosition() async {
    statetext = "يتم تحديد الموقع";
try{
    emit(GetGeoLocatorPermission());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
  
    if (!serviceEnabled) {
      statetext = "خطأ في الحصول علي الموقع";
      ShortToast(
          msg: "خطأ في الحصول علي الموقع",
      );

      throw Exception('خدمة الوصول للموقع غير مفعله');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
          msg: "من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة ",
      );
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(
            msg: "من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة ",
        );

        throw Exception('من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(DeniedForeverGeoLocatorPermission(
          'تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات'));

      throw Exception('تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات');
    }

    emit(SucessLocatorPermission());
    return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ));
  }catch(e){
    emit(DeniedGeoLocatorPermission(e.toString()));
    return null;
  }
  }
//azkarList
  Future<void> getazkar() async {
    try {
      statetext = 'تحميل الاذكار';

      emit(LodingAzkarDataState());
      var jsonText = await rootBundle.loadString(Assets.localdb.azkar);
      dynamic userMap = jsonDecode(jsonText);
      var azkar = Azkar.fromJson(userMap).azkar;
      azkarlist = azkar.toSet().toList();
      filteredList!.addAll(azkarlist!);
      statetext = 'تم تحميل الاذكار';
      onTap();
      emit(SuccessAzkarLoadingDataState());
    } catch (ex) {

    }
  }
//AzkarTapped
  Future<void> azkartapped(Category) async {
    try {
      list = [];
      statetext = 'تحميل الاذكار';

      emit(LodingAzkarDataState());

      azkarlist!.forEach((element) {
        if (element.category == Category) {
          list!.add(element);
        }
      });

      await onscroll(0);
      statetext = 'تم تحميل الاذكار';

      emit(SuccessAzkarLoadingDataState());
    } catch (ex) {}
  }

  Future<void> onscroll(index) async {
   try {
     
   
    await Future.delayed(Duration(milliseconds: 600));

    if (list![index].count!.isNotEmpty) {
      Counter = int.tryParse(list![index].count!)!;
    } else {
      Counter = 1;
    }
    if (Counter > 0) {
      CounterVisibility = true;
    } else {
      CounterVisibility = false;
    }

    emit(ScrollAzkar());
    } catch (e) {
   }
  }

  Future<void> onTap() async {
    try {
      
    
    player = AudioPlayer();
    player!.setAsset(Assets.music.click);
    player!.play();
    if (Counter > 1) {
      Counter--;
    } else {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate();
      }
      CounterVisibility = false;
       Ccontroller.nextPage();
      Counter = 0;
    }
    emit(OnAppearAzkar());
    } catch (e) {
    }
  }
  
  Future<void> PullTORE() async {
    isload = true;
    emit(LodingTodayDataState());
    try {
      CurrentPosition = await _determinePosition();
      if (CurrentPosition == null) {
        throw StateError('تعذر تحديد الموقع لتحميل مواقيت الصلاة');
      }
      await insertinDatabase();
      await getTodayData();
    } catch (e) {
      emit(ErrorTodayLoadingDataState(e.toString()));
    } finally {
      isload = false;
    }
  }

  void searchstate() {
    SState = !SState;

    search("");
    controller = TextEditingController();
    controller?.clear();
    emit(StateChanged());
  }

  void search(searchtext) {
    filteredList = [];

    emit(LodingAzkarDataState());

    if (searchtext == "" || searchtext == null) {
      filteredList!.addAll(azkarlist!);
    } else {
      azkarlist!.forEach((element) {
        if (element.category!.contains(searchtext)) {
          filteredList!.add(element);
        }
        ;
      });
      if (filteredList!.length < 1) {
        statetext = 'لا يوجد اذكار';
      }
      emit(SuccessAzkarLoadingDataState());
    }
  }

  void OnChangeTap(index) {
    currentPage = index;
  }

  /*void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // ...

          // Parse the message received
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );


            _notificationInfo = notification;
            totalNotifications++;

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _notificationInfo),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }

      // TODO: handle the received notifications

  }
   */
}
