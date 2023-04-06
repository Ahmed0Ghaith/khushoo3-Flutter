

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 
  void showToast({
    required String msg,

  }) =>
      Fluttertoast.showToast(
        msg: msg,
       toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

  void ShortToast({
    required String msg,

  }) =>
      Fluttertoast.showToast(
        msg: msg,
         toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
      );