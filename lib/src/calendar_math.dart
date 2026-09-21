import 'package:flutter/foundation.dart';

@immutable
class GregorianDate {
  final int year;
  final int month;
  final int day;

  const GregorianDate(this.year, this.month, this.day);

  @override
  String toString() => '$year-$month-$day';

  @override
  bool operator ==(Object other) =>
      other is GregorianDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);
}

@immutable
class EthiopicDate {
  final int year;
  final int month;
  final int day;

  const EthiopicDate(this.year, this.month, this.day);

  @override
  String toString() => '$year-$month-$day';

  @override
  bool operator ==(Object other) =>
      other is EthiopicDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);
}

class CalendarMath {
  static const int ethiopicEpoch = 1724221;

  static const List<String> ethiopicMonthAmharic = [
    'መስከረም',
    'ጥቅምት',
    'ኅዳር',
    'ታኅሣሥ',
    'ጥር',
    'የካቲት',
    'መጋቢት',
    'ሚያዝያ',
    'ግንቦት',
    'ሰኔ',
    'ሐምሌ',
    'ነሐሴ',
    'ጳጉሜ',
  ];

  static const List<String> ethiopicMonthEnglish = [
    'Meskerem',
    'Tikimt',
    'Hidar',
    'Tahsas',
    'Tir',
    'Yekatit',
    'Megabit',
    'Miyazya',
    'Ginbot',
    'Sene',
    'Hamle',
    'Nehase',
    'Pagume',
  ];

  static const List<String> weekdayAmharic = [
    'እሑድ',
    'ሰኞ',
    'ማክሰኞ',
    'ረቡዕ',
    'ሐሙስ',
    'ዓርብ',
    'ቅዳሜ',
  ];

  static const List<String> weekdayEnglish = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static const List<String> weekdayEnglishShort = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static const List<String> geexNumerals = [
    '፩',
    '፪',
    '፫',
    '፬',
    '፭',
    '፮',
    '፯',
    '፰',
    '፱',
    '፲',
    '፲፩',
    '፲፪',
    '፲፫',
    '፲፬',
    '፲፭',
    '፲፮',
    '፲፯',
    '፲፰',
    '፲፱',
    '፳',
  ];

  static bool isGregorianLeap(int year) =>
      (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;

  static bool isEthiopicLeap(int year) => year % 4 == 3;

  static int daysInEthiopicMonth(int year, int month) {
    if (month < 1 || month > 13) return 0;
    if (month == 13) return isEthiopicLeap(year) ? 6 : 5;
    return 30;
  }

  static int jdnFromGregorian(int year, int month, int day) {
    final a = (14 - month) ~/ 12;
    final y = year + 4800 - a;
    final m = month + 12 * a - 3;
    return day +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045;
  }

  static GregorianDate gregorianFromJdn(int jdn) {
    final a = jdn + 32044;
    final b = (4 * a + 3) ~/ 146097;
    final c = a - 146097 * b ~/ 4;
    final d = (4 * c + 3) ~/ 1461;
    final e = c - 1461 * d ~/ 4;
    final m = (5 * e + 2) ~/ 153;
    final day = e - (153 * m + 2) ~/ 5 + 1;
    final month = m + 3 - 12 * (m ~/ 10);
    final year = 100 * b + d - 4800 + m ~/ 10;
    return GregorianDate(year, month, day);
  }

  static int jdnFromEthiopic(int year, int month, int day) {
    return ethiopicEpoch +
        365 * (year - 1) +
        year ~/ 4 +
        30 * (month - 1) +
        (day - 1);
  }

  static EthiopicDate ethiopicFromJdn(int jdn) {
    final e = jdn - ethiopicEpoch;
    var year = (4 * e + 1463) ~/ 1461;
    while (365 * (year - 1) + year ~/ 4 > e) {
      year--;
    }
    final start = 365 * (year - 1) + year ~/ 4;
    final doy = e - start;
    final month = doy ~/ 30 + 1;
    final day = doy % 30 + 1;
    return EthiopicDate(year, month, day);
  }

  static int weekdayIndex(int jdn) => (jdn + 1) % 7;

  static int weekdayIndexFromGregorian(GregorianDate d) =>
      (jdnFromGregorian(d.year, d.month, d.day) + 1) % 7;

  static GregorianDate ethiopicToGregorian(EthiopicDate d) =>
      gregorianFromJdn(jdnFromEthiopic(d.year, d.month, d.day));

  static EthiopicDate gregorianToEthiopic(GregorianDate d) =>
      ethiopicFromJdn(jdnFromGregorian(d.year, d.month, d.day));
}
