import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/communication.dart';
import 'package:khushoo3/view_model/states.dart';

class privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (BuildContext context) => communication(),

  child:  BlocConsumer<communication, BaseStates>(
  listener: (BuildContext context, state) {},
  builder: (BuildContext context, state) {
    return SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(height: 20,),
              Text("خشوع"
                , style: Azkarstyle(), textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text(
                "تطبيق خشوع هو تطبيق اسلامي مفتوح المصدر اذا كنت مطور يمكنك مشاركه رأيك او التعديل والعمل عليه مع ذكر المصدر "
                , style: LightText(), textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text("بياناتك :"
                , style: LightText(), textAlign: TextAlign.right,),
              SizedBox(height: 20,),
              Text(
                "لا نجمع عنك اي بيانات فقط يتطلب التطبيق سماحيه الوصول للموقع لتحديد مواقيت الصلاه في بلدتك والبوصله لتحديد القبله. "
                , style: LightText(), textAlign: TextAlign.right,),

              SizedBox(height: 20,),
              Text("المطور :"
                , style: LightText(), textAlign: TextAlign.right,),
              SizedBox(height: 20,),
              Text(
                "تم تصميم وتطوير هذا التطبيق في نسخته الاولي عام 2021 |1443 هـ علي يد 'احمد غيث' ونطمع في كرم الله ان يجعل هذا التطبيق صدقة جاريه علي ارواح جميع اموات المسلمين."
                , style: LightText(), textAlign: TextAlign.right,),
              SizedBox(height: 20,),
              Text("للتواصل مع المطور"
                , style: Azkarstyle(), textAlign: TextAlign.center,),
              Text("devghaith@outlook.com"
                , style: LightText(), textAlign: TextAlign.center,),

              SizedBox(height: 20,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    communication.get(context).openFacebook();
                  }, icon: FaIcon(FontAwesomeIcons.facebook), color: Golden,),
                  IconButton(onPressed: () { communication.get(context).openWhatsapp();},
                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                    color: Golden,),
                  IconButton(onPressed: () {communication.get(context).openYoutube();},
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Golden,),
                  IconButton(
                    onPressed: () {communication.get(context).openEmail();}, icon: Icon(Icons.email), color: Golden,),


                ],
              )

            ],
          ),
        )
    );

  }
  ),

  );
}
