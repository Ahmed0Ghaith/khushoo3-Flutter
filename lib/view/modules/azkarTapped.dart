import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view/modules/misbaha.dart';
import 'package:khushoo3/view/modules/privacy.dart';
import 'package:khushoo3/view/modules/qiblah_compass.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';


import 'azkarSlider.dart';

class sliderList extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageVM, BaseStates>(
        listener: (context, state) {},
        builder: (context, state) {
        HomePageVM  VM = HomePageVM.get(context);
        final  azkardata = VM.filteredList!;
        final azkarcategories = <String>[];
        for (final element in azkardata) {
          if (element.category != null) {
            azkarcategories.add(element.category!);
          }
        }
          return Body(context,VM,azkardata,azkarcategories);
        });
  }

  Widget Body(context,VM,azkardata,azkarcategories) {
    return Expanded(
        child: Stack(
          children: [
            DefaultTabController(
                length: 5,
                initialIndex: VM.currentPage ,

                child: Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      toolbarHeight: 10,
                      backgroundColor: Colors.black,

                      bottom: TabBar(

                        labelColor: Golden,

                        unselectedLabelColor: DarkGolden,
                        labelPadding: const EdgeInsets.all(0.0),
                        indicatorColor: Golden,
                        onTap: (index) {
                          VM.OnChangeTap(index);
                        },
                        labelStyle: Headerstyle(),
                        tabs: [
                          Tab(
                            text: "الأذكار",
                          ),
                          Tab(
                            text: "السبحة",
                          ),
                          Tab(
                            text: "القبلة",
                          ),
                          Tab(
                            text: "التطبيق",
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                VM.currentPage == 0 ? VM.searchstate():null;


                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    body: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(15, 255, 255, 255),
                        ),
                        child: TabBarView(

                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Container(child: azkarBuilder(context,azkardata,azkarcategories)),
                            Center(child: misbaha()),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(child: getQibla()),
                            ),
                            privacy(),
                            Container(),
                          ],
                        ),
                      ),
                    ))),
            AnimatedContainer(
              color: Colors.black,
              height: 50,
              width: HomePageVM
                  .get(context)
                  .SState
                  ? MediaQuery
                  .of(context)
                  .size
                  .width
                  : 0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 70,
                      height: 50,
                      child: TextFormField(
                        controller: HomePageVM
                            .get(context)
                            .controller,
                        decoration: InputDecoration(
                            hintText: 'بحث عن ذكر', hintStyle: LightText()),
                        onChanged: ((value) {
                          HomePageVM.get(context).search(value);
                        }),
                        style: LightText(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                      ),
                    ),
                    // ),
                    Container(
                        alignment: Alignment.centerLeft,

                        child: IconButton(
                            onPressed: () {
                              HomePageVM.get(context).searchstate();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                            ))
                      // )
                    ),


                  ],
                ),
              ),
            )
          ],
        ));
  }

//Azkar Builder
  Widget azkarBuilder(context,azkardata,azkarcategories) {
    if (azkardata.length > 0) {
      return  ListView.separated(

            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildZekrItem(
                    azkarcategories.toSet().toList()[index], context),
            separatorBuilder: (context, index) => Container(),
            itemCount: azkarcategories
                .toSet()
                .length,
          );
         
      
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              '${HomePageVM
                  .get(context)
                  .statetext}',
              style: LightText(),
            )
          ],
        ),
      );
    }
  }

//Build Azkar Item
  Widget buildZekrItem(item, context) =>
      InkWell
        (
          onTap: () {
            HomePageVM.get(context).azkartapped(item);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return azkarslider();
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              child: Container(
                  height: 70.0,
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        children: [
                          Text(
                            (item.toString()),
                            style: Azkarstyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 5, 5, 5),
                        Color.fromARGB(2, 5, 5, 5)
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.bottomLeft,
                    ),
                  )),
            ),
          ));
}
