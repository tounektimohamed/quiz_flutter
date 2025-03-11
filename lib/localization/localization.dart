import 'package:flutter/material.dart';
import 'fr.dart';
import 'en.dart';
import 'ar.dart';

class Localization {
  static const Locale frLocale = Locale('fr', 'FR');
  static const Locale enLocale = Locale('en', 'US');
  static const Locale arLocale = Locale('ar', 'AR');

  static const List<Locale> supportedLocales = [frLocale, enLocale, arLocale];

  static Map<String, Map<String, String>> _localizedValues = {
    'fr': fr,
    'en': en,
    'ar': ar,
  };

  Locale _locale = frLocale;

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
  }

  static String translate(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    return _localizedValues[locale]?[key] ?? key;
  }

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization)!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return Localization.supportedLocales.contains(locale);
  }

  @override
  Future<Localization> load(Locale locale) async {
    return Localization();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}