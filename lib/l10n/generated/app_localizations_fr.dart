// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Khushoo';

  @override
  String get prayerTimes => 'Heures de prière';

  @override
  String get prayerTimeSettings => 'Paramètres des heures de prière';

  @override
  String get prayerTimeSettingsDescription =>
      'L\'heure d\'été est calculée automatiquement selon la localisation et la date. Vous pouvez ajuster chaque heure manuellement en minutes.';

  @override
  String get noAdjustment => 'Sans ajustement';

  @override
  String minuteAdjustment(String count) {
    return '$count minute(s)';
  }

  @override
  String get increaseMinute => 'Ajouter une minute';

  @override
  String get decreaseMinute => 'Retrancher une minute';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get close => 'Fermer';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Lever du soleil';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get azkar => 'Adhkar';

  @override
  String get misbaha => 'Chapelet';

  @override
  String get qibla => 'Qibla';

  @override
  String get appInfo => 'Application';

  @override
  String get search => 'Rechercher';

  @override
  String get searchHint => 'Rechercher dans les Adhkar';

  @override
  String get retry => 'Réessayer';

  @override
  String get loading => 'Chargement...';

  @override
  String get locationPermissionRequired =>
      'L\'accès à la localisation est requis pour déterminer les heures de prière et la Qibla.';

  @override
  String get locationDenied => 'Accès à la localisation refusé';

  @override
  String get locationDeniedForever =>
      'Accès à la localisation refusé définitivement';

  @override
  String get aboutTitle => 'Khushoo';

  @override
  String get aboutDescription =>
      'Khushoo est une application islamique open source. Si vous êtes développeur, vous pouvez donner votre avis, modifier et contribuer au projet en citant la source.';

  @override
  String get yourDataTitle => 'Vos données :';

  @override
  String get yourDataDescription =>
      'Nous ne collectons aucune donnée personnelle. L\'application nécessite uniquement l\'accès à la localisation pour calculer les heures de prière et la boussole pour la Qibla.';

  @override
  String get developerTitle => 'Développeur :';

  @override
  String get developerDescription =>
      'Conçu et développé par Ahmed Ghaith. Nous demandons à Allah de faire de cette application une aumône continue (Sadaqah Jariyah) pour tous les défunts musulmans.';

  @override
  String get contactDeveloper => 'Contacter le développeur';

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get arabic => 'Arabe';

  @override
  String get french => 'Français';
}
