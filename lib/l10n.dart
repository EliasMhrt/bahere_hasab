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

  static String monthName(int month) => isAmharic
      ? CalendarMath.ethiopicMonthAmharic[month - 1]
      : CalendarMath.ethiopicMonthEnglish[month - 1];

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
