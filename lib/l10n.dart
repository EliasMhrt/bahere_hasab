import 'package:flutter/material.dart';

import 'src/bahire_hasab.dart';
import 'src/calendar_math.dart';
import 'src/festivals.dart';

enum AppLanguage { amharic, english }

class L10n {
  L10n._();

  static final ValueNotifier<AppLanguage> lang = ValueNotifier(
    AppLanguage.amharic,
  );

  static bool get isAmharic => lang.value == AppLanguage.amharic;

  static String t(String amharic, String english) =>
      isAmharic ? amharic : english;

  static String get languageLabel =>
      isAmharic ? 'አማርኛ · Amharic' : 'English · እንግሊዝኛ';

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

  static String monthName(int month) => isAmharic
      ? CalendarMath.ethiopicMonthAmharic[month - 1]
      : CalendarMath.ethiopicMonthEnglish[month - 1];

  /// Shortened Ethiopian (Ethiopic) month name for the active language.
  static String shortMonthName(int month) =>
      shortMonthNameFor(lang.value, month);

  static String shortMonthNameFor(AppLanguage language, int month) =>
      (language == AppLanguage.amharic
          ? _ethiopicShortAmharic
          : _ethiopicShortEnglish)[month - 1];

  static String gregorianMonthShortFor(AppLanguage language, int month) =>
      (language == AppLanguage.amharic
          ? _gregorianShortAmharic
          : _gregorianShortEnglish)[month - 1];

  /// The name of [season] for the active language.
  static String seasonName(FastingSeason season) =>
      seasonNameFor(lang.value, season);

  static String seasonNameFor(AppLanguage language, FastingSeason season) =>
      language == AppLanguage.amharic ? season.amharicName : season.englishName;

  static String weekdayName(int index) => isAmharic
      ? CalendarMath.weekdayAmharic[index]
      : CalendarMath.weekdayEnglish[index];

  static String weekdayShort(int index) =>
      isAmharic ? weekdayName(index) : CalendarMath.weekdayEnglishShort[index];

  static String yearSuffix() => isAmharic ? 'ዓ.ም.' : 'E.C.';

  static String eraName() => isAmharic ? 'ዓመተ ምህረት' : 'Amete Mihret';

  static String eventName(CalendarEvent e) => isAmharic ? e.title : e.subtitle;

  static String eventSecondary(CalendarEvent e) =>
      isAmharic ? e.subtitle : e.title;

  static String evangelistName(BahireHasab bh) =>
      isAmharic ? bh.evangelistAmharic : bh.evangelistEnglish;

  static String fastStatusLabel(int seasonCount, int weeklyCount) => t(
    'በዚህ ወር ዋና በዓላትና ጾማት: $seasonCount ጾም/በዓል, $weeklyCount ሳምንታዊ ጾም',
    'Events this month: $seasonCount fasting events, $weeklyCount weekly fasts',
  );
}
