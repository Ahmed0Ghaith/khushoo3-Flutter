import 'package:khushoo3/view_model/network/remote/dio_helper.dart';
import 'package:khushoo3/models/SalatModel.dart';

import 'package:sqflite/sqflite.dart';

class CalendarCash {
  Database? database;

  void insertinDatabase() {
    diohelper
        .getData(
            url: "v1/calendar",
            query: ({
              "latitude": "30.585810",
              "longitude": "31.503500",
              "method": "5",
              "month": "6",
              "year": "2021",
            }))
        .then((value) {
              print(SalatModel.fromJson(value.data));
              if (SalatModel.fromJson(value.data).code == 200) {
                SalatModel.fromJson(value.data).data.forEach((element) {
                  database!.rawQuery(
                      'INSERT OR REPLACE INTO Salattime(Date, Salat, Time, Image) VALUES'
                      '("${element.date!.gregorian!.date}","الفجر","${element.timings!.fajr}", "assets/images/FR.jpg"),'
                      '("${element.date!.gregorian!.date}","الشروق","${element.timings!.sunrise}", "assets/images/SR.jpg"),'
                      '("${element.date!.gregorian!.date}","الظهر","${element.timings!.dhuhr}", "assets/images/ZH.jpg"),'
                      '("${element.date!.gregorian!.date}","العصر","${element.timings!.asr}", "assets/images/AS.jpg"),'
                      '("${element.date!.gregorian!.date}","المغرب","${element.timings!.maghrib}", "assets/images/MA.jpg"),'
                      '("${element.date!.gregorian!.date}","العشاء","${element.timings!.isha}", "assets/images/IS.jpg")');
                  
                });
              }
            })
        .catchError((error) {
      print('Error When Creating Table ${error.toString()}');
    });
  }
}

