
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/models/azkarModel.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';

class azkarslider extends StatelessWidget {
  List<Azkardata> Azkar = [];
  HomePageVM ?VM ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageVM, BaseStates>
      (

        listener: (context, state) {},
        builder: (context, state) {
       VM =   HomePageVM.get(context);
          Azkar =VM!.list!;
          if (Azkar.length > 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0,100,0,70),
              child: Container(



               child:

                  Stack(
                  children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(0,0,0,40),
                       child: Container(

                         child: CarouselSlider(

                               options: CarouselOptions(
                             scrollDirection: Axis.horizontal,





                                 scrollPhysics: BouncingScrollPhysics(),
                                 enableInfiniteScroll: false,

                                  onPageChanged: (index, reason) {
                                    VM!.onscroll(index);
                                        },
                                 height: MediaQuery
                                     .of(context)
                                     .size
                                     .height,
                                 autoPlay: false,
                                 enlargeCenterPage: true,
                               ),


                               items: Azkar.map((item) =>




                                               Container(

 width:  MediaQuery.of(context).size.width-80,
                                                     decoration: BoxDecoration(
                                                         border: Border.all(
                                                           color:Golden,
                                                         ),
                                                         borderRadius: BorderRadius.all(Radius.circular(10))

           )
                                                   ,
                                child:   Directionality( textDirection: TextDirection.rtl,



                                                   child: ClipRRect(
                                                     borderRadius: BorderRadius.all(
                                                         Radius.circular(10.0)),
                                                     child:Container(
                                                     color: Color.fromARGB(150, 0, 0, 0),
                                                    child:
                                                    SingleChildScrollView(
                                                         child:


                                                                    Container(




                                                child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                            child: Column(

                                                                              children: [


                                                                                SizedBox(
                                                                              height: 30,
                                                                            ),
                                                                                Text('${item.category}',style: Azkarstyle(),
                                                                                  textAlign: TextAlign.center,
                                                                                  overflow: TextOverflow.clip,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                ),
                                                                                Text('${item.zekr}',style: AzkarText(),
                                                                                 textAlign: TextAlign.center,
                                                                                  overflow: TextOverflow.clip,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Text('${item.description}',style: GrayText(),
                                                                                  textAlign: TextAlign.start,
                                                                                  overflow: TextOverflow.clip,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Text('${item.reference}',style: Headerstyle(),

                                                                                  textAlign: TextAlign.start,

                                                                                ),


                                                                              ],





                                                            ),


                                                          ),
                                                ),


           // Add your onPressed code here!


                                                                   ),
                                                       ),




                                                   ),
                                                 ),
                                   )




                                   )
                                   .toList()


                         ),
                       ),
                     ),
                     // Align(
                     //   alignment: Alignment.bottomCenter,
                     //   child: Container(
                     //     height: 50,
                     //     color: Colors.red,
                     //   ),
                     // )
                     Visibility (

                            visible:VM!.CounterVisibility ,
                       child: Padding(
                         padding: const EdgeInsets.only(bottom: 8),
                         child: Align(

                           alignment: Alignment.bottomCenter,

                           child: Container(

                             height: 70,
                             //child:FractionalTranslation(translation: Offset(0, .5),



                                 child: FloatingActionButton(

                                   onPressed: () => {
                                     VM!.onTap()
                                   },

                                   child:Text('${VM!.Counter}'),
                                 ),

                             ),
                           ),
                         ),
                       ),
                   //  ),

                    ],
                  ),

               // Visibility (
               //   visible:VM!.CounterVisibility ,
               //   child: Align(
               //
               //     alignment: Alignment.bottomCenter,

               //     child: Container(

               //       child:FractionalTranslation(translation: Offset(0, .5),
               //         child:
               //         FloatingActionButton(

               //           onPressed: () => {
               //             VM!.onTap()
               //           },

               //           child:Text('${VM!.Counter}'),
               //         ),
               //       ),
               //     ),
               //   ),
               // ),

              ),
            );
          } else {
            return Expanded(child:
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('${HomePageVM
                      .get(context)
                      .statetext}',
                    style: LightText(),
                  )
                ],
              ),


            )

            );
          }

        }


    );
  }


}