import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:khushoo3/models/SalatModel.dart';
import 'package:khushoo3/models/azkarModel.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:khushoo3/view_model/network/remote/dio_helper.dart';

class HomePageVM extends Cubit<BaseStates> {
  HomePageVM() : super(InitialState());
  

  final CarouselController Ccontroller = CarouselController();

  late int currentPage = 0;

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

  List<Azkardata>? azkarlist = [];
  List<Azkardata>? list = [];
  List<Azkardata>? filteredList = [];
  TextEditingController? controller;

  //Methods

  //CreateDataBase
  Future <void> createDatabase()  async{
    try {
    /*  emit(CreateDataBaseState());
      statetext = 'تهيئة قاعدة البيانات';*/
     await openDatabase(
        'CalendarCash.db',
        version: 1,
        onCreate: (_database, version) {
          _database
              .execute(
                  'CREATE TABLE Salattime (HDate TEXT, HMonth TEXT, Date TEXT , Salat TEXT, Time TEXT, Image TEXT)')
              .catchError((error) {
         Fluttertoast.showToast(
                          msg: "'خطأ في تهية قاعدة البيانات المحلية' ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      ); /* statetext = 'خطأ في تهية قاعدة البيانات المحلية';
            emit(ErrorCreateDataBaseState(error));*/
          });
        },
      ).then((value) =>
       {
            _database = value,
         /*   emit(SuccessCreateDataBaseState()),
            statetext = 'تم تهيئة قاعدة البيانات',*/

          });
    } catch (e) {
      statetext = 'خطأ في تهية قاعدة البيانات المحلية';
      emit(ErrorCreateDataBaseState(e.toString()));
    }
  }
//GetTodayData
  Future<void> getTodayData() async {
    try
    {
 isload=true;
    statetext = "تحميل بيانات الصلاة لليوم";
    emit(LodingTodayDataState());
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(DateTime.now());
if (_database==null)
await createDatabase();

    List value = await _database!
        .rawQuery("SELECT * FROM Salattime  Where Date='$formattedDate' ");
    if (value.length == 0) {
      CurrentPosition = await _determinePosition();
     
      var position = CurrentPosition;
      if (position != null) {
        await insertinDatabase();
        value = await _database!
            .rawQuery("SELECT * FROM Salattime  Where Date='$formattedDate' ");
      }
    }

    value.forEach((element) {
      model.add(element);
    });
    statetext = "تم تحميل البيانات";
    emit(SuccessTodayLoadingDataState());
   
  
  }catch(e)
    {

    }finally{
  isload=false;
   emit(DeniedGeoLocatorPermission(""));
    }
    }
void deleteDatabase()
{
  isload=true;
  if (_database==null)
    createDatabase();

  _database!.rawQuery("Delete FROM Salattime ");
  model=[];
  emit(LodingAPIDataState());
}
//GetDataFromApi
  Future<void> insertinDatabase() async {

    emit(LodingAPIDataState());
    statetext = "جار تحميل البيانات من الانترنت...";
    deleteDatabase();
    await diohelper
        .getData(
            url: "v1/calendar",
            query: ({
              "latitude": '${CurrentPosition!.latitude}',
              "longitude": '${CurrentPosition!.latitude}',
              "method": "5",
              "month": '${DateTime.now().month}',
              "year": '${DateTime.now().year}',
            }))
        .then((value) => {
              if (SalatModel.fromJson(value.data).code == 200)
                {
                  statetext = " تم تحميل البيانات من الانترنت",
                  emit(SuccessAPILoadingDataState()),
                  emit(UpdateDataState()),
                  statetext = "يتم تحديث المواقيت في قاعدة البيانات",
                  SalatModel.fromJson(value.data).data.forEach((element) {
                    try {
                      _database!.rawQuery(
                          'INSERT OR REPLACE INTO Salattime(HDate,HMonth,Date, Salat, Time, Image) VALUES'
                          '("${element.date!.hijri!.date}","${element.date!.hijri!.month}","${element.date!.gregorian!.date}","الفجر","${element.timings!.fajr}", "assets/images/FR.jpg"),'
                          '("","","${element.date!.gregorian!.date}","الشروق","${element.timings!.sunrise}", "assets/images/SR.jpg"),'
                          '("","","${element.date!.gregorian!.date}","الظهر","${element.timings!.dhuhr}", "assets/images/ZH.jpg"),'
                          '("","","${element.date!.gregorian!.date}","العصر","${element.timings!.asr}", "assets/images/AS.jpg"),'
                          '("","","${element.date!.gregorian!.date}","المغرب","${element.timings!.maghrib}", "assets/images/MA.jpg"),'
                          '("","","${element.date!.gregorian!.date}","العشاء","${element.timings!.isha}", "assets/images/IS.jpg")');
                    } catch (e) {
                   
                      statetext = "خطأ اثناء تحميل البيانات من الانترنت";
                      emit(ErrorUpdateDataState(e.toString()));
                    }
                  }),
                  
                  emit(SuccessUpdateDataState()),
                  statetext = "تم تحديث المواقيت في قاعدة البيانات",
                }
            })
        .catchError((error) {
     
      emit(ErrorAPILoadingDataState(error));
    });
    
  }
//LocationData
  Future<Position> _determinePosition() async {
    statetext = "يتم تحديد الموقع";

    emit(GetGeoLocatorPermission());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled()
    .catchError((onError){

    });
    if (!serviceEnabled) {
      statetext = "خطأ في الحصول علي الموقع";
      Fluttertoast.showToast(
          msg: "خطأ في الحصول علي الموقع",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return Future.error('خدمة الوصول للموقع غير مفعله');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
          msg: "من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        Fluttertoast.showToast(
            msg: "من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return Future.error(
            'من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(DeniedForeverGeoLocatorPermission(
          'تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات'));

      return Future.error(
          'تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات');
    }

    emit(SucessLocatorPermission());
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
  }
//azkarList
  Future<void> getazkar() async {
    try {
      statetext = 'تحميل الاذكار';

      emit(LodingAzkarDataState());
      var jsonText = await rootBundle.loadString('assets/localdb/azkar.json');
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
    player!.setAsset('assets/music/click.wav');
    player!.play();
    if (Counter > 1) {
      Counter--;
    } else {
      if (await Vibrate.canVibrate) {
        HapticFeedback.vibrate();
      }
      CounterVisibility = false;
      
      Ccontroller.nextPage();
      Counter = 0;
    }
    emit(OnAppearAzkar());
    } catch (e) {
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
}
