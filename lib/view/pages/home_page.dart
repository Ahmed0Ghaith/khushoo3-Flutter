import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view/modules/azkarTapped.dart';
import 'package:khushoo3/view/modules/salatSlider.dart';

import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:khushoo3/view/shared/themes.dart';


class HomePage extends StatelessWidget {
  List<Map> Model = [];
  HomePageVM? VM ;
  @override
  Widget build(BuildContext context) {

    return home(context);
  }

  Widget home(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomePageVM()
        ..getazkar()   ..getTodayData(),
      child: BlocConsumer<HomePageVM, BaseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          VM=HomePageVM.get(context);
          Model =VM!.model;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: getpage(state));
        },
      ),
    );
  }

  Widget getpage(state) {
    var s = Model;

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 0.3,
        backgroundColor: Golden,
      ),
      body: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: slider()),
     floatingActionButton: VM!.isload ?  CircularProgressIndicator(strokeWidth: 7,):  Container(
    height: 40.0,
    width: 40.0,
    child: FittedBox(
    child: FloatingActionButton(


        onPressed: () {
        VM!.deleteDatabase();
        VM!.getTodayData();
        },
        backgroundColor: Golden,
        child: const Icon(Icons.refresh, size:40,color: Colors.white,),
    ),) ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

    );
  }

  Widget mainContainer() {
    return Stack(
      children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          //CarouselSliderSalatTime
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: slider(),
          ),

          SizedBox(
            height: 10,
          ),
          //Body
          Directionality(textDirection: TextDirection.rtl, child: sliderList())
        ]),
      ],
    );
  }
}
