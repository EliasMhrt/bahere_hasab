import 'package:flutter/material.dart';

import 'l10n/app_language.dart';
import 'l10n/dictionaries.dart';
import 'src/bahire_hasab.dart';
import 'src/calendar_math.dart';
import 'src/festivals.dart';

export 'l10n/app_language.dart';

/// Lightweight, dependency-free localisation.
///
/// Amharic and English strings are written inline at the call site via
/// [t]`(amharic, english)`. Every other language looks the English string up in
/// its table (see `l10n/`) and falls back to Amharic (Ethiopic-script
/// languages) or English (Latin-script languages) when a key is missing.
class L10n {
  L10n._();

  static final ValueNotifier<AppLanguage> lang = ValueNotifier(
    AppLanguage.amharic,
  );

  static AppLanguage get language => lang.value;

  static bool get isAmharic => lang.value == AppLanguage.amharic;

  static String t(String amharic, String english) =>
      forLanguage(lang.value, amharic, english);

  /// Like [t], but substitutes `{name}` placeholders with values from
  /// [params]. The English template doubles as the translation key, so strings
  /// that embed runtime values can still be translated in full.
  static String tp(
    String amharic,
    String english, [
    Map<String, Object?>? params,
  ]) {
    var value = forLanguage(lang.value, amharic, english);
    if (params != null) {
      for (final entry in params.entries) {
        value = value.replaceAll('{${entry.key}}', '${entry.value}');
      }
    }
    return value;
  }

  /// Resolves a string for [language] without touching the active language.
  static String forLanguage(
    AppLanguage language,
    String amharic,
    String english,
  ) {
    switch (language) {
      case AppLanguage.amharic:
        return amharic;
      case AppLanguage.english:
        return english;
      default:
        final value = kTranslations[language]?[english];
        if (value != null && value.isNotEmpty) return value;
        return language.usesEthiopicScript ? amharic : english;
    }
  }

  static String get languageLabel => language.displayLabel;

  static const List<String> _ethiopicShortAmharic = [
    'መስከ',
    'ጥቅም',
    'ኅዳር',
    'ታኅሳ',
    'ጥር',
    'የካቲ',
    'መጋቢ',
    'ሚያዝ',
    'ግንቦ',
    'ሰኔ',
    'ሐምሌ',
    'ነሐሴ',
    'ጳጉሜ',
  ];

  static const List<String> _ethiopicShortEnglish = [
    'Mes',
    'Tik',
    'Hid',
    'Tah',
    'Tir',
    'Yek',
    'Meg',
    'Miy',
    'Gin',
    'Sen',
    'Ham',
    'Neh',
    'Pag',
  ];

  static const List<String> _gregorianShortEnglish = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _gregorianShortAmharic = [
    'ጃን',
    'ፌብ',
    'ማር',
    'ኤፕ',
    'ሜይ',
    'ጁን',
    'ጁላ',
    'ኦገ',
    'ሴፕ',
    'ኦክ',
    'ኖቬ',
    'ዲሴ',
  ];

  static const List<String> _gregorianFullAmharic = [
    'ጃንዋሪ',
    'ፌብሩዋሪ',
    'ማርች',
    'ኤፕሪል',
    'ሜይ',
    'ጁን',
    'ጁላይ',
    'ኦገስት',
    'ሴፕቴምበር',
    'ኦክቶበር',
    'ኖቬምበር',
    'ዲሴምበር',
  ];

  static const List<String> _gregorianFullEnglish = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// Full Gregorian month name for the active language.
  static String gregorianMonthName(int month) =>
      t(_gregorianFullAmharic[month - 1], _gregorianFullEnglish[month - 1]);

  static String _clip(String value, int max) {
    final runes = value.runes.toList(growable: false);
    if (runes.length <= max) return value;
    return String.fromCharCodes(runes.take(max));
  }

  static String monthName(int month) => monthNameFor(lang.value, month);

  static String monthNameFor(AppLanguage language, int month) => forLanguage(
    language,
    CalendarMath.ethiopicMonthAmharic[month - 1],
    CalendarMath.ethiopicMonthEnglish[month - 1],
  );

  /// Shortened Ethiopian (Ethiopic) month name for the active language.
  static String shortMonthName(int month) =>
      shortMonthNameFor(lang.value, month);

  static String shortMonthNameFor(AppLanguage language, int month) {
    switch (language) {
      case AppLanguage.amharic:
        return _ethiopicShortAmharic[month - 1];
      case AppLanguage.english:
        return _ethiopicShortEnglish[month - 1];
      default:
        return _clip(monthNameFor(language, month), 5);
    }
  }

  static String gregorianMonthShortFor(AppLanguage language, int month) {
    switch (language) {
      case AppLanguage.amharic:
        return _gregorianShortAmharic[month - 1];
      case AppLanguage.english:
        return _gregorianShortEnglish[month - 1];
      default:
        return language.usesEthiopicScript
            ? _gregorianShortAmharic[month - 1]
            : _gregorianShortEnglish[month - 1];
    }
  }

  /// The name of [season] for the active language.
  static String seasonName(FastingSeason season) =>
      seasonNameFor(lang.value, season);

  static String seasonNameFor(AppLanguage language, FastingSeason season) =>
      forLanguage(language, season.amharicName, season.englishName);

  static String weekdayName(int index) => weekdayNameFor(lang.value, index);

  static String weekdayNameFor(AppLanguage language, int index) => forLanguage(
    language,
    CalendarMath.weekdayAmharic[index],
    CalendarMath.weekdayEnglish[index],
  );

  static String weekdayShort(int index) {
    switch (lang.value) {
      case AppLanguage.amharic:
        return CalendarMath.weekdayAmharic[index];
      case AppLanguage.english:
        return CalendarMath.weekdayEnglishShort[index];
      default:
        return _clip(weekdayName(index), 4);
    }
  }

  static String yearSuffix() => forLanguage(lang.value, 'ዓ.ም.', 'E.C.');

  static String eraName() =>
      forLanguage(lang.value, 'ዓመተ ምህረት', 'Amete Mihret');

  static String eventName(CalendarEvent e) => forLanguage(lang.value, e.title, e.subtitle);

  static String eventSecondary(CalendarEvent e) {
    switch (lang.value) {
      case AppLanguage.amharic:
        return e.subtitle;
      case AppLanguage.english:
        return e.title;
      default:
        final primary = eventName(e);
        return e.subtitle == primary ? '' : e.subtitle;
    }
  }

  static String evangelistName(BahireHasab bh) =>
      forLanguage(lang.value, bh.evangelistAmharic, bh.evangelistEnglish);

  static String fastStatusLabel(int seasonCount, int weeklyCount) => t(
    'በዚህ ወር ዋና በዓላትና ጾማት: $seasonCount ጾም/በዓል, $weeklyCount ሳምንታዊ ጾም',
    'Events this month: $seasonCount fasting events, $weeklyCount weekly fasts',
  );
}
