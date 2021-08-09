
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:khushoo3/models/azkarModel.dart';

import 'azkarSlider.dart';
class sliderList extends StatelessWidget
{
  late TabController _tabController;

  HomePageVM ?VM;
  List<Azkardata> _azkardata=[];
  List<String> _azkarcategories=[];
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<HomePageVM,BaseStates>(
    listener: (context, state) {},
    builder: (context, state)
    {
      VM=HomePageVM.get(context);
      _azkardata=VM!.filteredList!;
      if (_azkardata.length>0)
      {
        _azkardata.forEach((element)
        {
          _azkarcategories.add(element.category!);
        });
      }
return Body(context);
    }
  );

  }

  Widget Body(context)
  {
    return  Expanded(
        child:  Stack(
          children: [
            DefaultTabController(

                length: 5,
                child: Scaffold(
                    appBar: AppBar(


                      toolbarHeight: 50,
                      backgroundColor: Colors.black87,

                      bottom: TabBar(labelColor:Golden ,
                        unselectedLabelColor:DarkGolden ,
                        labelPadding:const EdgeInsets.all(0.0),
                        indicatorColor:Golden ,
onTap: (index){

  VM!.OnChangeTap(index);
},

                        labelStyle:  Headerstyle(),
                        tabs: [

                          Tab(text: "الأذكار",),
                          Tab(text: "السبحة",),
                          Tab(text: "القبلة",),
                          Tab(text: "الخصوصية",),
                          Container(

                            child: IconButton (  onPressed: (){
                              VM!.Isenablesearch?
                               VM!.searchstate():null;
                            }, icon: Icon(Icons.search,color: Colors.white,), color: Colors.white,),
                          )
                        ],
                      ),

                    ),
                    body: Container (
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/Background.png'), fit: BoxFit. cover,),

                      ),
                      child:  Container(
                        child:  TabBarView(
                          children: [
                            Container( decoration: BoxDecoration(color: Color.fromARGB(15, 255, 255,255) ,),
                                child: azkarBuilder(context)
                            ),
                            Icon(Icons.directions_transit),
                            Icon(Icons.directions_bike),
                            Icon(Icons.directions_bike),
                            Container(),

                          ],
                        ),
                      ),

                    )
                )
            ),

            AnimatedContainer(
              color: Colors.black,
              height: 50,
              width:HomePageVM.get(context).SState? MediaQuery.of(context).size.width:0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Stack(

                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width-70,
                      height: 50,
                      child: TextFormField(
                        controller:HomePageVM.get(context).controller ,
                        decoration: InputDecoration(hintText: 'بحث عن ذكر',hintStyle:LightText() ),
                        onChanged: ((value){HomePageVM.get(context).search(value);}),
                        style:  LightText(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {

                          }
                          return null;
                        },
                      ),
                    ),
                    // ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          // child: AnimatedAlign(
                          //     alignment:  HomePageVM.get(context).SState? Alignment.centerRight:Alignment.centerLeft,
                          //     duration: const Duration(seconds: 1),
                          //     curve: Curves.fastOutSlowIn,
                          child:
                          IconButton(onPressed: (){
                            HomePageVM.get(context).searchstate();
                          }, icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,) )
                        // )
                      ),
                    )
                    //  Container(height: 20,
                    //
                    //   )
                  ],
                ),
              ),
            )
          ],
        )
    );


  }
  Widget azkarBuilder(context)
  {
    if (_azkardata.length>0)
    {
      return  ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildZekrItem(_azkarcategories.toSet().toList()[index], context),
        separatorBuilder:  (context, index) => Container(),
        itemCount:_azkarcategories.toSet().length ,);
    }
    else
    {
      return  Expanded(child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text('${HomePageVM.get(context).statetext}',
              style:LightText() ,
            )
          ],
        ),




      )

      );



    }


  }
  Widget buildZekrItem(item, context) => InkWell(

      onTap: (){
        HomePageVM.get(context).azkartapped(item);

        showDialog(

            context: context,
            builder: (BuildContext context) {
              return

                azkarslider();

            }
        );






      },
      child:   Padding(
        padding: const EdgeInsets.all(10.0),

        child:
        ClipRRect(borderRadius:BorderRadius.all(Radius.circular(15.0)) ,

          child:
          Container(
              height:70.0,
              child:   Container(
                width: double.infinity,
                height: 1.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,15,0),
                  child: Row(
                    children: [
                      Text((item.toString()),style: Azkarstyle() ,),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient
                  (
                  colors: [
                    Color.fromARGB(255,5 , 5, 5),
                    Color.fromARGB(2, 5,5, 5)
                  ],

                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,

                ),
              )

          ),
        ),
      ));

}