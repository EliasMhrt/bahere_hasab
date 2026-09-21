import 'calendar_math.dart';

class BahireHasab {
  final int year;

  BahireHasab(this.year);

  int get ameteAlem => 5500 + year;

  int get mateneRabiet => ameteAlem ~/ 4;

  int get evangelistRemainder => ameteAlem % 4;

  String get evangelistAmharic {
    switch (evangelistRemainder) {
      case 1:
        return 'ማቴዎስ';
      case 2:
        return 'ማርቆስ';
      case 3:
        return 'ሉቃስ';
      default:
        return 'ዮሐንስ';
    }
  }

  String get evangelistEnglish {
    switch (evangelistRemainder) {
      case 1:
        return 'Matthew';
      case 2:
        return 'Mark';
      case 3:
        return 'Luke';
      default:
        return 'John';
    }
  }

  int get rawMedeb => ameteAlem % 19;

  int get medeb {
    final m = rawMedeb;
    return m == 0 ? 19 : m;
  }

  int get wenber => rawMedeb == 0 ? 18 : rawMedeb - 1;

  int get metqi => (wenber * 19) % 30;

  int get abektie => (wenber * 11) % 30;

  int get abushakir => ((ameteAlem - 1) % 532) + 1;

  int get easterJdn => orthodoxEasterJdn(year + 8);

  static int orthodoxEasterJdn(int gregorianYear) {
    final a = gregorianYear % 4;
    final b = gregorianYear % 7;
    final c = gregorianYear % 19;
    final d = (19 * c + 15) % 30;
    final e = (2 * a + 4 * b - d + 34) % 7;
    final jMonth = (d + e + 114) ~/ 31;
    final jDay = (d + e + 114) % 31 + 1;
    final a2 = (14 - jMonth) ~/ 12;
    final yj = gregorianYear + 4800 - a2;
    final mj = jMonth + 12 * a2 - 3;
    return jDay + (153 * mj + 2) ~/ 5 + 365 * yj + yj ~/ 4 - 32083;
  }

  int jdnOf(int month, int day) =>
      CalendarMath.jdnFromEthiopic(year, month, day);

  int get enkutatashJdn => jdnOf(1, 1);

  int get ninevehStartJdn => easterJdn - 69;

  int get ninevehEndJdn => easterJdn - 67;

  int get abiyTsomStartJdn => easterJdn - 55;

  int get abiyTsomEndJdn => easterJdn - 1;

  int get debreZeitJdn => easterJdn - 28;

  int get hosannaJdn => easterJdn - 7;

  int get sikletJdn => easterJdn - 2;

  int get rikbeJdn => easterJdn + 24;

  int get ergetJdn => easterJdn + 39;

  int get pentecostJdn => easterJdn + 49;

  int get hawaryatStartJdn => easterJdn + 50;

  int get dihnetStartJdn => easterJdn + 52;

  int get hawaryatEndJdn => jdnOf(11, 5);

  bool get hasHawaryatFast => hawaryatStartJdn <= hawaryatEndJdn;

  int daysInMonth(int month) => CalendarMath.daysInEthiopicMonth(year, month);

  bool get isLeap => CalendarMath.isEthiopicLeap(year);
}
