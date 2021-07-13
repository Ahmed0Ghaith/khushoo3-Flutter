import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/models/SalatModel.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:khushoo3/view_model/network/remote/dio_helper.dart';
class HomePageVM extends Cubit<BaseStates>
{
  HomePageVM() : super(InitialState());


  
static HomePageVM get(context) => BlocProvider.of(context);



Position?CurrentPosition;
List<Map>  model=[];
Database? _database;
 String?  statetext ;

 //Methods

 //CreateDataBase
void createDatabase() {
    try {
    
          emit(CreateDataBaseState());
          statetext='تهيئة قاعدة البيانات';
          openDatabase(
      'CalendarCash.db',
      version: 1,
      onCreate: (_database, version) {
        _database
            .execute(
            'CREATE TABLE Salattime (HDate TEXT, HMonth TEXT, Date TEXT , Salat TEXT, Time TEXT, Image TEXT)')
            .catchError((error) {
          statetext='خطأ في تهية قاعدة البيانات المحلية';
           emit(ErrorCreateDataBaseState(error));
        });
      },
      
    ).then((value) =>
            {
              
                _database =value,
                emit(SuccessCreateDataBaseState()),
                statetext='تم تهيئة قاعدة البيانات',
                getTodayData ()
 
        });
        }catch (e) {
        statetext='خطأ في تهية قاعدة البيانات المحلية';
           emit(ErrorCreateDataBaseState(e.toString()));
        }
    }

//GetTodayData
Future<void>  getTodayData ()
async { 
   emit(LodingTodayDataState());
   statetext="تحميل بيانات الصلاة لليوم";
      var formatter =  DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(DateTime.now());


     List value = await _database!.rawQuery("SELECT * FROM Salattime  Where Date='$formattedDate' ");
       if (value.length==0)
       {
         CurrentPosition =await _determinePosition();
        var position=CurrentPosition;
        if (position!=null)
        {
        await insertinDatabase();
        value = await _database!.rawQuery("SELECT * FROM Salattime  Where Date='$formattedDate' ");
     
        }
          }
         
     value.forEach((element)
      {
        model.add(element);
      });
     statetext="تم تحميل البيانات";
      emit(SuccessTodayLoadingDataState());
   
  }
//GetDataFromApi
Future<void> insertinDatabase ()async
{
   emit(LodingAPIDataState());
   statetext="جار تحميل البيانات من الانترنت...";
    _database!.rawQuery("Delete FROM Salattime ");
  await  diohelper.getData(url: "v1/calendar", query: (
        {
          "latitude":'${CurrentPosition!.latitude}',
          "longitude":'${CurrentPosition!.latitude}',
          "method":"5",
          "month":'${DateTime.now().month}',
          "year":'${DateTime.now().year}',
        }
    )).then((value) =>{


   
      if (SalatModel.fromJson(value.data).code==200)
        {
      statetext=" تم تحميل البيانات من الانترنت",
           emit(SuccessAPILoadingDataState()),
          emit(UpdateDataState()),
          statetext="يتم تحديث المواقيت في قاعدة البيانات",

          SalatModel.fromJson(value.data).data.forEach((element) {
            try {
              
           
            _database!.rawQuery('INSERT OR REPLACE INTO Salattime(HDate,HMonth,Date, Salat, Time, Image) VALUES'
                '("${element.date!.hijri!.date}","${element.date!.hijri!.month}","${element.date!.gregorian!.date}","الفجر","${element.timings!.fajr}", "assets/images/FR.jpg"),'
                '("","","${element.date!.gregorian!.date}","الشروق","${element.timings!.sunrise}", "assets/images/SR.jpg"),'
                '("","","${element.date!.gregorian!.date}","الظهر","${element.timings!.dhuhr}", "assets/images/ZH.jpg"),'
                '("","","${element.date!.gregorian!.date}","العصر","${element.timings!.asr}", "assets/images/AS.jpg"),'
                '("","","${element.date!.gregorian!.date}","المغرب","${element.timings!.maghrib}", "assets/images/MA.jpg"),'
                '("","","${element.date!.gregorian!.date}","العشاء","${element.timings!.isha}", "assets/images/IS.jpg")');

            } catch (e) {
              statetext="خطأ اثناء تحميل البيانات من الانترنت";
     emit(ErrorUpdateDataState(e.toString()));

            }
          }),
          emit(SuccessUpdateDataState()),
          statetext="تم تحديث المواقيت في قاعدة البيانات",

        }

    }).catchError((error) {
     emit(  ErrorAPILoadingDataState(error));
    });

  }
//LocationData
Future<Position> _determinePosition() async {
  statetext="يتم تحديد الموقع";

  emit(GetGeoLocatorPermission());
  bool serviceEnabled;
  LocationPermission permission;

  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    statetext="خطأ في الحصول علي الموقع";

    return Future.error('خدمة الوصول للموقع غير مفعله');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
  emit(DeniedGeoLocatorPermission('من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة'));
 
      return Future.error('من فضلك قم بالسماح للوصول للموقع لتحديد مواقيت الصلاة والقبلة');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
  emit(DeniedForeverGeoLocatorPermission( 'تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات'));
  
    return Future.error('تم حظر الوصول للموقع من فضلك قم بالسماح من داخل الاعدادات');
  } 
  

  emit(SucessLocatorPermission());
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true);
}
 
 
 
}

