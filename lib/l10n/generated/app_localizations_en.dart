// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Khushoo';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get prayerTimeSettings => 'Prayer Time Settings';

  @override
  String get prayerTimeSettingsDescription =>
      'Daylight saving time is calculated automatically based on location and date. You can manually adjust each prayer time by minutes.';

  @override
  String get noAdjustment => 'No adjustment';

  @override
  String minuteAdjustment(String count) {
    return '$count minute';
  }

  @override
  String get increaseMinute => 'Add minute';

  @override
  String get decreaseMinute => 'Subtract minute';

  @override
  String get reset => 'Reset';

  @override
  String get close => 'Close';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get azkar => 'Azkar';

  @override
  String get misbaha => 'Misbaha';

  @override
  String get qibla => 'Qibla';

  @override
  String get appInfo => 'App';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search in Azkar';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get locationPermissionRequired =>
      'Location access is required to determine prayer times and Qibla direction.';

  @override
  String get locationDenied => 'Location permission denied';

  @override
  String get locationDeniedForever => 'Location permission permanently denied';

  @override
  String get aboutTitle => 'Khushoo';

  @override
  String get aboutDescription =>
      'Khushoo is an open-source Islamic app. If you are a developer, you can share feedback, modify, or contribute to it with proper attribution.';

  @override
  String get yourDataTitle => 'Your Data:';

  @override
  String get yourDataDescription =>
      'We do not collect any personal data. The app only requires location permission to calculate prayer times and the compass to locate the Qibla.';

  @override
  String get developerTitle => 'Developer:';

  @override
  String get developerDescription =>
      'Designed and developed by Ahmed Ghaith. We pray to Allah that this app serves as ongoing charity (Sadaqah Jariyah) for all departed Muslims.';

  @override
  String get contactDeveloper => 'Contact Developer';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get french => 'French';
}
