import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khushoo3/gen/assets.gen.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';
import 'package:khushoo3/view/modules/azkarTapped.dart';
import 'package:khushoo3/view/modules/salatSlider.dart';
import 'package:khushoo3/view/modules/prayer_time_settings.dart';

import 'package:khushoo3/view/shared/colors.dart';
import 'package:khushoo3/view_model/home_page_VM.dart';
import 'package:khushoo3/view_model/states.dart';
import 'package:khushoo3/view/shared/themes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return home(context);
  }

  Widget home(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomePageVM()
        ..getazkar()
        ..getTodayData(),
      child: BlocConsumer<HomePageVM, BaseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final vm = HomePageVM.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: vm.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: theme,
            home: getpage(state, context),
          );
        },
      ),
    );
  }

  Widget getpage(state, BuildContext context) {
    return Builder(
      builder: (pageContext) {
        final l10n = AppLocalizations.of(pageContext);
        final vm = HomePageVM.get(pageContext);

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n?.prayerTimes ?? 'مواقيت الصلاة'),
            actions: [
              PopupMenuButton<String>(
                tooltip: l10n?.language ?? 'Language',
                icon: const Icon(Icons.language),
                onSelected: (code) => vm.changeLanguage(code),
                itemBuilder: (menuContext) => [
                  PopupMenuItem(
                    value: 'ar',
                    child: Text(l10n?.arabic ?? 'العربية'),
                  ),
                  PopupMenuItem(
                    value: 'en',
                    child: Text(l10n?.english ?? 'English'),
                  ),
                  PopupMenuItem(
                    value: 'fr',
                    child: Text(l10n?.french ?? 'Français'),
                  ),
                ],
              ),
              IconButton(
                tooltip: l10n?.prayerTimeSettings ?? 'إعدادات مواقيت الصلاة',
                icon: const Icon(Icons.settings),
                onPressed: () => showPrayerTimeSettingsDialog(
                  pageContext,
                  vm,
                ),
              ),
            ],
            backgroundColor: Golden,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.background.provider(),
                fit: BoxFit.cover,
              ),
            ),
            child: slider(),
          ),
        );
      },
    );
  }

  Widget mainContainer() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      //CarouselSliderSalatTime
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container() /*slider()*/,
      ),

      SizedBox(
        height: 10,
      ),
      //Body
      Directionality(textDirection: TextDirection.rtl, child: sliderList())
    ]);
  }
}
