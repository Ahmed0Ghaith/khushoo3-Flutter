// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'خشوع';

  @override
  String get prayerTimes => 'مواقيت الصلاة';

  @override
  String get prayerTimeSettings => 'إعدادات مواقيت الصلاة';

  @override
  String get prayerTimeSettingsDescription =>
      'التوقيت الصيفي يُحتسب تلقائيًا حسب الموقع والتاريخ. يمكنك ضبط كل وقت يدويًا بالدقائق.';

  @override
  String get noAdjustment => 'بدون تعديل';

  @override
  String minuteAdjustment(String count) {
    return '$count دقيقة';
  }

  @override
  String get increaseMinute => 'تقديم دقيقة';

  @override
  String get decreaseMinute => 'تأخير دقيقة';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get close => 'إغلاق';

  @override
  String get fajr => 'الفجر';

  @override
  String get sunrise => 'الشروق';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get azkar => 'الأذكار';

  @override
  String get misbaha => 'السبحة';

  @override
  String get qibla => 'القبلة';

  @override
  String get appInfo => 'التطبيق';

  @override
  String get search => 'بحث';

  @override
  String get searchHint => 'بحث في الأذكار';

  @override
  String get retry => 'محاولة';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get locationPermissionRequired =>
      'يجب السماح للتطبيق بالوصول للموقع لتحديد مواقيت الصلاة والقبلة';

  @override
  String get locationDenied => 'تم رفض الوصول للموقع';

  @override
  String get locationDeniedForever => 'تم رفض الوصول للموقع الي الابد';

  @override
  String get aboutTitle => 'خشوع';

  @override
  String get aboutDescription =>
      'تطبيق خشوع هو تطبيق اسلامي مفتوح المصدر اذا كنت مطور يمكنك مشاركه رأيك او التعديل والعمل عليه مع ذكر المصدر';

  @override
  String get yourDataTitle => 'بياناتك :';

  @override
  String get yourDataDescription =>
      'لا نجمع عنك اي بيانات فقط يتطلب التطبيق سماحيه الوصول للموقع لتحديد مواقيت الصلاه في بلدتك والبوصله لتحديد القبله.';

  @override
  String get developerTitle => 'المطور :';

  @override
  String get developerDescription =>
      'تم تصميم وتطوير هذا التطبيق في نسخته الاولي عام 2021 |1443 هـ علي يد \'احمد غيث\' ونطمع في كرم الله ان يجعل هذا التطبيق صدقة جاريه علي ارواح جميع اموات المسلمين.';

  @override
  String get contactDeveloper => 'للتواصل مع المطور';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get french => 'الفرنسية';
}
