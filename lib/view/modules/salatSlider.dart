
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/Helpers/NotificationBadge.dart';
import 'package:khushoo3/view/modules/qiblah_compass.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:hijri/hijri_calendar.dart';
import 'azkarTapped.dart';

class slider extends StatelessWidget {
  HijriCalendar? _today;

  List<String> CachedImages =
  [
  'assets/images/FR.jpg',
  'assets/images/SR.jpg',
  'assets/images/ZH.jpg',
  'assets/images/AS.jpg',
  'assets/images/MA.jpg',
  'assets/images/AS.jpg',

  ];
  List<Map> Model = [];
HomePageVM ?VM;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageVM, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        VM = HomePageVM.get(context);
        Model=VM!.model;
        _today = HijriCalendar.now();
        HijriCalendar.setLocal('ar');
        return sliderwidget(state, context);
      },
    );
  }
  //SliderWidget
  Widget sliderwidget(state, context) {
    return Stack(

      children: [
        SizedBox(height: 16.0),
        NotificationBadge(totalNotifications: VM!.totalNotifications),
        SizedBox(height: 16.0),
        Column(
            mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: header(),
          ),
          //CarouselSliderSalatTime


                RefreshIndicator(
              child:   SingleChildScrollView( physics: AlwaysScrollableScrollPhysics(), scrollDirection: Axis.vertical, child:
           Container(child: (() {
                if (Model.length > 0) {
                  return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        height: 170,
                        enlargeCenterPage: true,
                      ),
                      items: Model.map((item) => Container(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(item['Image'],
                                          fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(200, 255, 255, 255),
                                                    Color.fromARGB(2, 255, 255, 255)
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.bottomLeft,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20.0, right: 20.0),
                                                  child: Text("${item["Salat"]}",
                                                      style: TextStyle(
                                                          fontSize: 35,
                                                          fontFamily: 'GaliModern')),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.0)),
                                              child: Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    color: Golden,
                                                  ),
                                                  child: Text(
                                                      item['Time']
                                                          .toString()
                                                          .replaceAll('(EET)', ''),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                      ))),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          )).toList());
                } else {
                  return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        height: 170,
                        enlargeCenterPage: true,
                      ),
                      items: CachedImages.map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(item,
                                      fit: BoxFit.cover, width: 1000.0),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 255, 255, 255),
                                                Color.fromARGB(2, 255, 255, 255)
                                              ],
                                              begin: Alignment.bottomRight,
                                              end: Alignment.bottomLeft,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              )),
                        ),
                      )).toList());
                }
              })()),
             /* Positioned.fill(
                child:  Align(
                alignment: Alignment.bottomLeft,
                child: Container(

                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Golden,
                      borderRadius:BorderRadius.circular(50)

                  ),child: Icon(Icons.refresh,size: 20,color: Colors.white,),

                ),
              ),
              )*/



         ), onRefresh: () => VM!.PullTORE(),),

          SizedBox(
            height: 10,
          ),
          Directionality(textDirection: TextDirection.rtl, child: sliderList())
        ]),
      ],
    );
  }
  //Header Time
  Widget header()  {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              if (_today == null) {
                return "--";
              }

              return '${_today!.toFormat("MMMM")}';
            })(), style: Headerstyle()),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              if (_today == null) {
                return "--";
              }

              return '${_today!.toFormat("dd-mm-yyyy")}';
            })(), style: Headerstyle()),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              if (_today == null) {
                return "--";
              }

              return '${_today!.getDayName()}';
            })(), style: Headerstyle()),
          ],
        )
      ],
    );
  }
}
