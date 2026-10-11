import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:khushoo3/gen/assets.gen.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';
import 'azkarTapped.dart';

String getLocalizedPrayerName(BuildContext context, String? name) {
  final l10n = AppLocalizations.of(context);
  if (l10n == null || name == null) return name ?? '';
  switch (name.trim()) {
    case 'الفجر':
    case 'Fajr':
      return l10n.fajr;
    case 'الشروق':
    case 'Sunrise':
      return l10n.sunrise;
    case 'الظهر':
    case 'Dhuhr':
      return l10n.dhuhr;
    case 'العصر':
    case 'Asr':
      return l10n.asr;
    case 'المغرب':
    case 'Maghrib':
      return l10n.maghrib;
    case 'العشاء':
    case 'Isha':
      return l10n.isha;
    default:
      return name;
  }
}

class slider extends StatelessWidget {
  final CachedImages = <String>[
    Assets.images.fr.path,
    Assets.images.sr.path,
    Assets.images.zh.path,
    Assets.images.as.path,
    Assets.images.ma.path,
    Assets.images.isha.path,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageVM, BaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final VM = HomePageVM.get(context);
        final Model = VM.model;
        return sliderwidget(state, context, Model, VM);
      },
    );
  }

  //SliderWidget
  Widget sliderwidget(state, context, Model, VM) {
    return Stack(
      children: [
        SizedBox(height: 16.0),
        //  NotificationBadge(totalNotifications: VM!.totalNotifications),
        SizedBox(height: 16.0),
        Column(mainAxisSize: MainAxisSize.max, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: header(context),
          ),
          //CarouselSliderSalatTime
          RefreshIndicator(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                child: (() {
                  if (Model.length > 0) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        height: 170,
                        enlargeCenterPage: true,
                      ),
                      items: Model.map<Widget>((item) => Container(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          item['Image'] == 'assets/images/IS.jpg'
                                              ? Assets.images.isha.path
                                              : item['Image'],
                                          fit: BoxFit.cover,
                                          width: 1000.0),
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
                                                    Color.fromARGB(
                                                        200, 255, 255, 255),
                                                    Color.fromARGB(
                                                        2, 255, 255, 255)
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.bottomLeft,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20.0, right: 20.0),
                                                  child: Text(
                                                      getLocalizedPrayerName(
                                                          context, item["Salat"]),
                                                      style: TextStyle(
                                                          fontSize: 35,
                                                          fontFamily:
                                                              'GaliModern')),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      VM.displayPrayerTime(
                                                          item),
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
                          )).toList(),
                    );
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: false,
                        height: 170,
                        enlargeCenterPage: true,
                      ),
                      items: CachedImages.map<Widget>((item) => Container(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(2, 5, 2, 5),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
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
                                                    Color.fromARGB(
                                                        200, 255, 255, 255),
                                                    Color.fromARGB(
                                                        2, 255, 255, 255)
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
                          )).toList(),
                    );
                  }
                })(),
              ),
            ),
            onRefresh: () => VM!.PullTORE(),
          ),
          SizedBox(height: 10),
          Directionality(
            textDirection: Directionality.of(context),
            child: sliderList(),
          )
        ]),
      ],
    );
  }

  //Header Time
  Widget header(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    HijriCalendar.setLocal(langCode == 'ar' ? 'ar' : 'en');
    final todayHijri = HijriCalendar.now();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              return '${todayHijri.toFormat("MMMM")}';
            })(), style: Headerstyle()),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              return '${todayHijri.toFormat("dd-MM-yyyy")}';
            })(), style: Headerstyle()),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text((() {
              return '${todayHijri.getDayName()}';
            })(), style: Headerstyle()),
          ],
        )
      ],
    );
  }
}
