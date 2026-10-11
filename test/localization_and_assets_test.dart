import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khushoo3/gen/assets.gen.dart';
import 'package:khushoo3/l10n/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Localization tests (ar, en, fr)', () {
    test('Arabic localizations load correct strings', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('ar'));
      expect(l10n.prayerTimes, 'مواقيت الصلاة');
      expect(l10n.fajr, 'الفجر');
      expect(l10n.azkar, 'الأذكار');
      expect(l10n.misbaha, 'السبحة');
      expect(l10n.qibla, 'القبلة');
      expect(l10n.arabic, 'العربية');
    });

    test('English localizations load correct strings', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(l10n.prayerTimes, 'Prayer Times');
      expect(l10n.fajr, 'Fajr');
      expect(l10n.azkar, 'Azkar');
      expect(l10n.misbaha, 'Misbaha');
      expect(l10n.qibla, 'Qibla');
      expect(l10n.english, 'English');
    });

    test('French localizations load correct strings', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('fr'));
      expect(l10n.prayerTimes, 'Heures de prière');
      expect(l10n.fajr, 'Fajr');
      expect(l10n.azkar, 'Adhkar');
      expect(l10n.misbaha, 'Chapelet');
      expect(l10n.qibla, 'Qibla');
      expect(l10n.french, 'Français');
    });

    test('Supported locales include ar, en, fr', () {
      final codes = AppLocalizations.supportedLocales.map((l) => l.languageCode).toList();
      expect(codes, containsAll(['ar', 'en', 'fr']));
    });
  });

  group('FlutterGen Assets tests', () {
    test('Image asset paths are strongly typed and correct', () {
      expect(Assets.images.background.path, 'assets/images/Background.png');
      expect(Assets.images.isha.path, 'assets/images/isha.jpg');
      expect(Assets.images.fr.path, 'assets/images/FR.jpg');
      expect(Assets.images.sr.path, 'assets/images/SR.jpg');
      expect(Assets.images.zh.path, 'assets/images/ZH.jpg');
      expect(Assets.images.as.path, 'assets/images/AS.jpg');
      expect(Assets.images.ma.path, 'assets/images/MA.jpg');
      expect(Assets.images.qibla.path, 'assets/images/Qibla.png');
    });

    test('Audio and local database asset paths are generated', () {
      expect(Assets.music.click, 'assets/music/click.wav');
      expect(Assets.localdb.azkar, 'assets/localdb/azkar.json');
    });
  });
}
