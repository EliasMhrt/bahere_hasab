import 'bahire_hasab.dart';
import 'calendar_math.dart';

enum EventKind { fixedFeast, moveableFeast, fasting, commemoration }

enum FastStatus { none, weekly, seasonal }

/// A named fasting season of the Ethiopian Orthodox Tewahedo Church.
class FastingSeason {
  final String amharicName;
  final String englishName;
  final int startJdn;
  final int endJdn;

  const FastingSeason({
    required this.amharicName,
    required this.englishName,
    required this.startJdn,
    required this.endJdn,
  });

  String nameFor(bool amharic) => amharic ? amharicName : englishName;
}

class FixedFeast {
  final int month;
  final int day;
  final String amharicName;
  final String englishName;
  final String? description;
  final bool isMajor;

  const FixedFeast(
    this.month,
    this.day,
    this.amharicName,
    this.englishName, {
    this.description,
    this.isMajor = false,
  });
}

class MonthlyCommemoration {
  final int day;
  final String amharicName;
  final String englishName;

  const MonthlyCommemoration(this.day, this.amharicName, this.englishName);
}

class CalendarEvent {
  final String title;
  final String subtitle;
  final EventKind kind;
  final int startJdn;
  final int endJdn;
  final bool isMajor;

  const CalendarEvent({
    required this.title,
    required this.subtitle,
    required this.kind,
    required this.startJdn,
    required this.endJdn,
    this.isMajor = false,
  });

  bool get isSingleDay => startJdn == endJdn;
}

class Festivals {
  static const List<FixedFeast> fixedFeasts = [
    FixedFeast(
      1,
      1,
      'እንቁጣጣሽ',
      'Enkutatash (Ethiopian New Year)',
      description: 'Start of the new Ethiopian year.',
      isMajor: true,
    ),
    FixedFeast(
      1,
      17,
      'መስቀል',
      'Meskel (Finding of the True Cross)',
      description: 'Commemorates the discovery of the True Cross.',
      isMajor: true,
    ),
    FixedFeast(
      3,
      21,
      'የሥምጥን በዓል',
      'Feast of St. Mary of Zion',
      description:
          'Commemorates the bringing of the Ark of the Covenant to Axum.',
    ),
    FixedFeast(
      4,
      29,
      'ገና',
      'Genna (Ethiopian Christmas)',
      description: 'Nativity of Jesus Christ.',
      isMajor: true,
    ),
    FixedFeast(
      5,
      11,
      'ጥምቀት',
      'Timkat (Epiphany)',
      description: 'Baptism of Jesus Christ.',
      isMajor: true,
    ),
    FixedFeast(7, 29, 'የክብር በዓል', 'Annunciation Show (Debre Zeit)'),
    FixedFeast(
      11,
      5,
      'የሐዋርያት በዓል',
      'Feast of the Holy Apostles',
      description: 'Peter and Paul and the Holy Apostles.',
      isMajor: true,
    ),
    FixedFeast(
      12,
      13,
      'ደብረ ታቦር',
      'Debre Tabor (Transfiguration)',
      description: 'Transfiguration of Christ on Mount Tabor.',
    ),
    FixedFeast(
      12,
      16,
      'ፍልሰታ',
      'Filseta (Dormition of St. Mary)',
      description: 'Dormition of the Mother of God.',
      isMajor: true,
    ),
  ];

  static const List<MonthlyCommemoration> monthlyCommemorations = [
    MonthlyCommemoration(12, 'ቅዱስ ሚካኤል', 'St. Michael'),
    MonthlyCommemoration(19, 'ቅዱስ ገብርኤል', 'St. Gabriel'),
    MonthlyCommemoration(21, 'ቅድስት ማርያም', 'St. Mary'),
    MonthlyCommemoration(23, 'ቅዱስ ጊዮርጊስ', 'St. George'),
  ];

  const Festivals._();

  static List<CalendarEvent> eventsForYear(int ethiopicYear) {
    final bh = BahireHasab(ethiopicYear);
    final events = <CalendarEvent>[];

    for (final f in fixedFeasts) {
      events.add(
        CalendarEvent(
          title: f.amharicName,
          subtitle: f.englishName,
          kind: EventKind.fixedFeast,
          startJdn: bh.jdnOf(f.month, f.day),
          endJdn: bh.jdnOf(f.month, f.day),
          isMajor: f.isMajor,
        ),
      );
    }

    for (var month = 1; month <= 13; month++) {
      for (final c in monthlyCommemorations) {
        if (c.day > CalendarMath.daysInEthiopicMonth(ethiopicYear, month)) {
          continue;
        }
        events.add(
          CalendarEvent(
            title: c.amharicName,
            subtitle: c.englishName,
            kind: EventKind.commemoration,
            startJdn: bh.jdnOf(month, c.day),
            endJdn: bh.jdnOf(month, c.day),
          ),
        );
      }
    }

    events.addAll([
      CalendarEvent(
        title: 'ጾመ ነነዌ',
        subtitle: 'Fast of Nineveh',
        kind: EventKind.fasting,
        startJdn: bh.ninevehStartJdn,
        endJdn: bh.ninevehEndJdn,
      ),
      CalendarEvent(
        title: 'ዐቢይ ጾም (ሁዳደ)',
        subtitle: 'Great Lent (Hudade)',
        kind: EventKind.fasting,
        startJdn: bh.abiyTsomStartJdn,
        endJdn: bh.abiyTsomEndJdn,
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ደብረ ዘይት',
        subtitle: 'Mid-Lent Sunday',
        kind: EventKind.moveableFeast,
        startJdn: bh.debreZeitJdn,
        endJdn: bh.debreZeitJdn,
      ),
      CalendarEvent(
        title: 'ሆሳዕና',
        subtitle: 'Palm Sunday',
        kind: EventKind.moveableFeast,
        startJdn: bh.hosannaJdn,
        endJdn: bh.hosannaJdn,
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ስቅለት',
        subtitle: 'Good Friday (Crucifixion)',
        kind: EventKind.moveableFeast,
        startJdn: bh.sikletJdn,
        endJdn: bh.sikletJdn,
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ፋሲካ',
        subtitle: 'Easter (Resurrection)',
        kind: EventKind.moveableFeast,
        startJdn: bh.easterJdn,
        endJdn: bh.easterJdn,
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ርክበ ካህናት',
        subtitle: 'Rikbe Kahanat (Priests\' Assembly)',
        kind: EventKind.moveableFeast,
        startJdn: bh.rikbeJdn,
        endJdn: bh.rikbeJdn,
      ),
      CalendarEvent(
        title: 'ዕርገት',
        subtitle: 'Ascension',
        kind: EventKind.moveableFeast,
        startJdn: bh.ergetJdn,
        endJdn: bh.ergetJdn,
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ጰራቅሎጦስ',
        subtitle: 'Peraqlitos (Pentecost)',
        kind: EventKind.moveableFeast,
        startJdn: bh.pentecostJdn,
        endJdn: bh.pentecostJdn,
        isMajor: true,
      ),
      if (bh.hasHawaryatFast)
        CalendarEvent(
          title: 'ጾመ ሐዋርያት',
          subtitle: 'Fast of the Apostles',
          kind: EventKind.fasting,
          startJdn: bh.hawaryatStartJdn,
          endJdn: bh.hawaryatEndJdn,
        ),
      CalendarEvent(
        title: 'ጾመ ነቢያት',
        subtitle: 'Fast of the Prophets (Advent)',
        kind: EventKind.fasting,
        startJdn: bh.jdnOf(3, 15),
        endJdn: bh.jdnOf(4, 28),
        isMajor: true,
      ),
      CalendarEvent(
        title: 'ጾም ገሐድ',
        subtitle: 'Fast of Gahad (Christmas Eve)',
        kind: EventKind.fasting,
        startJdn: bh.jdnOf(4, 28),
        endJdn: bh.jdnOf(4, 28),
      ),
      CalendarEvent(
        title: 'ጾመ ፍልሰታ',
        subtitle: 'Fast of the Assumption (Filseta)',
        kind: EventKind.fasting,
        startJdn: bh.jdnOf(12, 1),
        endJdn: bh.jdnOf(12, 15),
        isMajor: true,
      ),
    ]);

    events.sort((a, b) => a.startJdn.compareTo(b.startJdn));
    return events;
  }

  static List<CalendarEvent> eventsOnJdn(List<CalendarEvent> events, int jdn) {
    return events.where((e) => e.startJdn <= jdn && jdn <= e.endJdn).toList();
  }

  /// The named fasting seasons of a given Ethiopian year.
  ///
  /// Order matters: when seasons overlap (e.g. Gahad coincides with the last
  /// day of the Advent fast), the earlier entry is reported by
  /// [fastingSeasonOnJdn].
  static List<FastingSeason> fastingSeasonsForYear(int ethiopicYear) {
    final bh = BahireHasab(ethiopicYear);
    return [
      FastingSeason(
        amharicName: 'ጾመ ጽጌ (ጾመ ቍስቍዋም)',
        englishName: 'Fast of Tsige (Zemene Tsige)',
        startJdn: bh.jdnOf(1, 16),
        endJdn: bh.jdnOf(2, 26),
      ),
      FastingSeason(
        amharicName: 'ጾመ ነነዌ',
        englishName: 'Fast of Nineveh',
        startJdn: bh.ninevehStartJdn,
        endJdn: bh.ninevehEndJdn,
      ),
      FastingSeason(
        amharicName: 'ዐቢይ ጾም (ሁዳዴ)',
        englishName: 'Great Lent (Hudade)',
        startJdn: bh.abiyTsomStartJdn,
        endJdn: bh.abiyTsomEndJdn,
      ),
      FastingSeason(
        amharicName: 'ጾም ገሐድ',
        englishName: 'Fast of Gahad',
        startJdn: bh.jdnOf(4, 28),
        endJdn: bh.jdnOf(4, 28),
      ),
      FastingSeason(
        amharicName: 'ጾመ ነቢያት (ጾመ ልደት)',
        englishName: 'Fast of the Prophets (Advent)',
        startJdn: bh.jdnOf(3, 15),
        endJdn: bh.jdnOf(4, 28),
      ),
      FastingSeason(
        amharicName: 'ጾመ ፍልሰታ',
        englishName: 'Fast of the Assumption (Filseta)',
        startJdn: bh.jdnOf(12, 1),
        endJdn: bh.jdnOf(12, 15),
      ),
      if (bh.hasHawaryatFast)
        FastingSeason(
          amharicName: 'ጾመ ሐዋርያት',
          englishName: 'Fast of the Apostles',
          startJdn: bh.hawaryatStartJdn,
          endJdn: bh.hawaryatEndJdn,
        ),
    ];
  }

  /// The named fasting season active on [jdn], or null if none is active.
  ///
  /// Weekly (Wednesday/Friday) fasts are not a season and return null.
  static FastingSeason? fastingSeasonOnJdn(int jdn) {
    final et = CalendarMath.ethiopicFromJdn(jdn);
    for (final season in fastingSeasonsForYear(et.year)) {
      if (jdn >= season.startJdn && jdn <= season.endJdn) {
        return season;
      }
    }
    return null;
  }

  static FastStatus fastStatusOnJdn(int jdn) {
    final et = CalendarMath.ethiopicFromJdn(jdn);
    final bh = BahireHasab(et.year);

    if (jdn >= bh.easterJdn && jdn <= bh.pentecostJdn) {
      return FastStatus.none;
    }

    final inTsige = jdn >= bh.jdnOf(1, 16) && jdn <= bh.jdnOf(2, 26);
    final inNineveh = jdn >= bh.ninevehStartJdn && jdn <= bh.ninevehEndJdn;
    final inAbiy = jdn >= bh.abiyTsomStartJdn && jdn <= bh.abiyTsomEndJdn;
    final inNebiyat = jdn >= bh.jdnOf(3, 15) && jdn <= bh.jdnOf(4, 28);
    final inFilseta = jdn >= bh.jdnOf(12, 1) && jdn <= bh.jdnOf(12, 15);
    final inHawaryat =
        bh.hasHawaryatFast &&
        jdn >= bh.hawaryatStartJdn &&
        jdn <= bh.hawaryatEndJdn;

    if (inTsige ||
        inNineveh ||
        inAbiy ||
        inNebiyat ||
        inFilseta ||
        inHawaryat) {
      return FastStatus.seasonal;
    }

    final weekday = CalendarMath.weekdayIndex(jdn);
    if (weekday == 3 || weekday == 5) {
      return FastStatus.weekly;
    }

    return FastStatus.none;
  }
}
