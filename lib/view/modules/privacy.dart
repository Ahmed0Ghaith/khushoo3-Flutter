import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';
import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view/shared/styles.dart';
import 'package:khushoo3/view_model/communication.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';

class privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (BuildContext context) => communication(),

  child:  BlocConsumer<communication, BaseStates>(
  listener: (BuildContext context, state) {},
  builder: (BuildContext context, state) {
    final l10n = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final align = isRtl ? TextAlign.right : TextAlign.left;

    return SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            textDirection: Directionality.of(context),
            children: [
              SizedBox(height: 20,),
              Text(l10n?.aboutTitle ?? "خشوع"
                , style: Azkarstyle(), textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text(
                l10n?.aboutDescription ?? "تطبيق خشوع هو تطبيق اسلامي مفتوح المصدر اذا كنت مطور يمكنك مشاركه رأيك او التعديل والعمل عليه مع ذكر المصدر "
                , style: LightText(), textAlign: TextAlign.center,
              ),
              SizedBox(height: 16,),
              Card(
                color: Backgroundcolor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n?.language ?? "اللغة", style: Headerstyle()),
                      DropdownButton<String>(
                        value: HomePageVM.get(context).currentLocale.languageCode,
                        dropdownColor: Backgroundcolor,
                        style: Headerstyle(),
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(value: 'ar', child: Text(l10n?.arabic ?? 'العربية')),
                          DropdownMenuItem(value: 'en', child: Text(l10n?.english ?? 'English')),
                          DropdownMenuItem(value: 'fr', child: Text(l10n?.french ?? 'Français')),
                        ],
                        onChanged: (val) {
                          if (val != null) HomePageVM.get(context).changeLanguage(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(l10n?.yourDataTitle ?? "بياناتك :"
                , style: LightText(), textAlign: align,),
              SizedBox(height: 20,),
              Text(
                l10n?.yourDataDescription ?? "لا نجمع عنك اي بيانات فقط يتطلب التطبيق سماحيه الوصول للموقع لتحديد مواقيت الصلاه في بلدتك والبوصله لتحديد القبله. "
                , style: LightText(), textAlign: align,),

              SizedBox(height: 20,),
              Text(l10n?.developerTitle ?? "المطور :"
                , style: LightText(), textAlign: align,),
              SizedBox(height: 20,),
              Text(
                l10n?.developerDescription ?? "تم تصميم وتطوير هذا التطبيق في نسخته الاولي عام 2021 |1443 هـ علي يد 'احمد غيث' ونطمع في كرم الله ان يجعل هذا التطبيق صدقة جاريه علي ارواح جميع اموات المسلمين."
                , style: LightText(), textAlign: align,),
              SizedBox(height: 20,),
              Text(l10n?.contactDeveloper ?? "للتواصل مع المطور"
                , style: Azkarstyle(), textAlign: TextAlign.center,),
              SizedBox(height: 10,),
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
