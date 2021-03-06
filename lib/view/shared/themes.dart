import 'package:flutter/services.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme =  ThemeData(
  //ThemeColors
  backgroundColor:Backgroundcolor,
  primaryColor:Golden,
  disabledColor:DarkGolden,
    primarySwatch: Colors.amber,

    //AppBarTheme
  appBarTheme: AppBarTheme(

    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Backgroundcolor,

    )

  ),



);
