import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view_model/network/bloc_observer.dart';
import 'package:khushoo3/view_model/network/remote/dio_helper.dart';
import 'package:khushoo3/view/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  diohelper.init();
  
  // Initialize Firebase
  await Firebase.initializeApp();
 
  // Initialize OneSignal
  OneSignal.initialize("784dab78-8048-44be-9d82-6831b4dcdcd8");
  
  // Request notification permission
  OneSignal.Notifications.requestPermission(true);
  
  runApp(HomePage());
}


