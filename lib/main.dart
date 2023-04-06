import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khushoo3/view_model/network/bloc_observer.dart';

import 'package:khushoo3/view_model/network/remote/dio_helper.dart';


import 'package:khushoo3/view/pages/home_page.dart';
void main()  {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
    diohelper.init();
     Firebase.initializeApp();
 
  //Remove this method to stop OneSignal Debugging 
OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

OneSignal.shared.setAppId("784dab78-8048-44be-9d82-6831b4dcdcd8");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
});
  
    runApp(HomePage());
}


