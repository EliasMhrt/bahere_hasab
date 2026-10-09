import 'package:bahere_hasab/src/bahire_hasab.dart';
import 'package:bahere_hasab/src/calendar_math.dart';
import 'package:bahere_hasab/src/festivals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Gregorian JDN conversion (Fliegel–Van Flandern)', () {
    test('known anchors', () {
      expect(CalendarMath.jdnFromGregorian(2000, 1, 1), 2451545);
      expect(CalendarMath.jdnFromGregorian(1970, 1, 1), 2440588);
      expect(CalendarMath.jdnFromGregorian(2026, 8, 22), 2461275);
      expect(CalendarMath.jdnFromGregorian(2026, 9, 11), 2461295);
    });

    test('round trip across a range', () {
      for (var y = 1900; y <= 2050; y++) {
        for (var m = 1; m <= 12; m++) {
          final d = GregorianDate(y, m, 1);
          final back = CalendarMath.gregorianFromJdn(
            CalendarMath.jdnFromGregorian(d.year, d.month, d.day),
          );
          expect(back, d, reason: 'jdn round trip failed for $d');
        }
      }
    });

    test('weekday indexing (0 = Sunday)', () {
      // 22 Aug 2026 was a Saturday, 11 Sept 2026 a Friday.
      expect(CalendarMath.weekdayIndex(2461275), 6);
      expect(CalendarMath.weekdayIndex(2461295), 5);
      // 2000-01-01 was a Saturday.
      expect(CalendarMath.weekdayIndex(2451545), 6);
      // 1970-01-01 was a Thursday.
      expect(CalendarMath.weekdayIndex(2440588), 4);
    });
  });

  group('Ethiopic conversion (Beyene–Kudlek, epoch 1724221)', () {
    test('1 Meskerem of an E.C. year is Enkutatash (Sept 11/12)', () {
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2019, 1, 1)),
        const GregorianDate(2026, 9, 11),
      );
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2000, 1, 1)),
        const GregorianDate(2007, 9, 12),
      );
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2016, 1, 1)),
        const GregorianDate(2023, 9, 12),
      );
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2017, 1, 1)),
        const GregorianDate(2024, 9, 11),
      );
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2020, 1, 1)),
        const GregorianDate(2027, 9, 12),
      );
    });

    test('16 Nehase 2018 = 22 Aug 2026 (Wikipedia anchor)', () {
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2018, 12, 16)),
        const GregorianDate(2026, 8, 22),
      );
      expect(
        CalendarMath.gregorianToEthiopic(const GregorianDate(2026, 8, 22)),
        const EthiopicDate(2018, 12, 16),
      );
    });

    test('1 Jan 2000 = 22 Tahsas 1992', () {
      expect(
        CalendarMath.gregorianToEthiopic(const GregorianDate(2000, 1, 1)),
        const EthiopicDate(1992, 4, 22),
      );
    });

    test('JDN value of the Wikipedia anchor', () {
      expect(CalendarMath.jdnFromEthiopic(2018, 12, 16), 2461275);
      expect(
        CalendarMath.ethiopicFromJdn(2461275),
        const EthiopicDate(2018, 12, 16),
      );
    });

    test('round trip across a range of Ec years', () {
      for (var y = 1900; y <= 2100; y++) {
        for (var m = 1; m <= 13; m++) {
          final days = CalendarMath.daysInEthiopicMonth(y, m);
          final d = EthiopicDate(y, m, days);
          final back = CalendarMath.ethiopicFromJdn(
            CalendarMath.jdnFromEthiopic(d.year, d.month, d.day),
          );
          expect(back, d, reason: 'Ec round trip failed for $d');
        }
      }
    });

    test('leap years have a 6th Pagume day (years ≡ 3 mod 4)', () {
      expect(CalendarMath.isEthiopicLeap(2015), isTrue);
      expect(CalendarMath.isEthiopicLeap(2019), isTrue);
      expect(CalendarMath.isEthiopicLeap(2018), isFalse);
      expect(CalendarMath.isEthiopicLeap(2016), isFalse);
      expect(CalendarMath.daysInEthiopicMonth(2019, 13), 6);
      expect(CalendarMath.daysInEthiopicMonth(2018, 13), 5);
    });

    test('Pagume 6 of the leap year 2019 is 11 Sept 2027', () {
      expect(
        CalendarMath.ethiopicToGregorian(const EthiopicDate(2019, 13, 6)),
        const GregorianDate(2027, 9, 11),
      );
    });
  });

  group('Orthodox (Julian) Easter computus', () {
    void checkFasika(int gYear, int month, int day) {
      final jdn = BahireHasab.orthodoxEasterJdn(gYear);
      final g = CalendarMath.gregorianFromJdn(jdn);
      expect(g.month, month, reason: 'Easter month for $gYear');
      expect(g.day, day, reason: 'Easter day for $gYear');
    }

    test('known Orthodox Easter dates', () {
      checkFasika(2020, 4, 19);
      checkFasika(2023, 4, 16);
      checkFasika(2024, 5, 5);
      checkFasika(2025, 4, 20);
      checkFasika(2026, 4, 12);
      checkFasika(2013, 5, 5);
    });

    test('Fasika of 2018 E.C. is 12 April 2026 (EOTC schedule)', () {
      final bh = BahireHasab(2018);
      final g = CalendarMath.gregorianFromJdn(bh.easterJdn);
      expect(g, const GregorianDate(2026, 4, 12));
    });

    test('Great Lent 2018 E.C. matches the official EOTC schedule', () {
      final bh = BahireHasab(2018);
      expect(
        CalendarMath.gregorianFromJdn(bh.abiyTsomStartJdn),
        const GregorianDate(2026, 2, 16),
      );
      expect(
        CalendarMath.gregorianFromJdn(bh.abiyTsomEndJdn),
        const GregorianDate(2026, 4, 11),
      );
    });
  });

  group('Bahire Hasab year values', () {
    test('2017 E.C. values', () {
      final bh = BahireHasab(2017);
      expect(bh.ameteAlem, 7517);
      expect(bh.mateneRabiet, 1879);
      expect(bh.evangelistRemainder, 1);
      expect(bh.evangelistEnglish, 'Matthew');
      expect(bh.evangelistAmharic, 'ማቴዎስ');
      expect(bh.rawMedeb, 12);
      expect(bh.medeb, 12);
      expect(bh.wenber, 11);
      expect(bh.metqi, 29);
      expect(bh.abektie, 1);
      expect(bh.abektie + bh.metqi, 30);
      expect(bh.abushakir, 69);
      expect(bh.isLeap, isFalse);
    });

    test('Nineveh is a Monday and Easter a Sunday (±7k) sequence', () {
      for (var y = 2000; y <= 2030; y++) {
        final bh = BahireHasab(y);
        expect(
          CalendarMath.weekdayIndex(bh.ninevehStartJdn),
          1,
          reason: 'Nineveh must be Monday in $y',
        );
        expect(
          CalendarMath.weekdayIndex(bh.easterJdn),
          0,
          reason: 'Easter must be Sunday in $y',
        );
        expect(
          CalendarMath.weekdayIndex(bh.sikletJdn),
          5,
          reason: 'Good Friday in $y',
        );
        expect(
          CalendarMath.weekdayIndex(bh.hosannaJdn),
          0,
          reason: 'Hosanna Sunday in $y',
        );
        expect(
          CalendarMath.weekdayIndex(bh.ergetJdn),
          4,
          reason: 'Ascension Thursday in $y',
        );
        expect(
          CalendarMath.weekdayIndex(bh.pentecostJdn),
          0,
          reason: 'Pentecost Sunday in $y',
        );
      }
    });
  });

  group('Festivals & fasting', () {
    test('events for 2018 E.C. include the moveable cycle', () {
      final bh = BahireHasab(2018);
      final events = Festivals.eventsForYear(2018);
      final fasika = events.firstWhere((e) => e.title == 'ፋሲካ');
      expect(fasika.startJdn, bh.easterJdn);
      final genna = events.firstWhere((e) => e.title == 'ገና');
      expect(
        CalendarMath.gregorianFromJdn(genna.startJdn),
        const GregorianDate(2026, 1, 7),
      );
      final meskel2019 = Festivals.eventsForYear(
        2019,
      ).firstWhere((e) => e.title == 'መስቀል');
      expect(
        CalendarMath.gregorianFromJdn(meskel2019.startJdn),
        const GregorianDate(2026, 9, 27),
      );
    });

    test('fasting status samples', () {
      // Friday 27 March 2026 is inside Great Lent (seasonal).
      final inLent = CalendarMath.jdnFromGregorian(2026, 3, 27);
      expect(Festivals.fastStatusOnJdn(inLent), FastStatus.seasonal);

      // Wednesday 4 Nov 2026 falls inside Zemene Tsige (Meskerem 16 –
      // Tikimt 26, ~27 Sep – 5 Nov 2026), so it is a seasonal fast.
      final tsige = CalendarMath.jdnFromGregorian(2026, 11, 4);
      expect(Festivals.fastStatusOnJdn(tsige), FastStatus.seasonal);
      final tsigeSeason = Festivals.fastingSeasonOnJdn(tsige);
      expect(tsigeSeason?.englishName, 'Fast of Tsige (Zemene Tsige)');

      // Wednesday 11 Nov 2026 sits between Zemene Tsige and Advent (Hidar 15,
      // ~24 Nov) and after the Apostles fast ended (12 July), so it is a plain
      // Wednesday fast.
      final wednesday = CalendarMath.jdnFromGregorian(2026, 11, 11);
      expect(Festivals.fastStatusOnJdn(wednesday), FastStatus.weekly);

      // A Sunday inside the Easter–Pentecost season is not a fast day.
      final sunday = CalendarMath.jdnFromGregorian(2026, 5, 24);
      expect(Festivals.fastStatusOnJdn(sunday), FastStatus.none);

      // 10 Dec 2025 falls inside the Fast of the Prophets (Hidar 15 – Tahsas 28).
      final advent = CalendarMath.jdnFromGregorian(2025, 12, 10);
      expect(Festivals.fastStatusOnJdn(advent), FastStatus.seasonal);
    });
  });

  group('Book cross-check — 2001 E.C. worked example', () {
    // From "ባሕረ ሐሳብ" (Aleka Y. Fenta W. Yohannes, ethiopianorthodox.org):
    // 2001 E.C. → Amete Alem 7501, Wenber 14, Abektie 4, Metqi 26,
    // Fasika ሚያዝያ 11 (= 19 Apr 2009), Rikbe Kahanat ግንቦት 5, etc.
    test('year values', () {
      final bh = BahireHasab(2001);
      expect(bh.ameteAlem, 7501);
      expect(bh.mateneRabiet, 1875);
      expect(bh.evangelistRemainder, 1);
      expect(bh.evangelistEnglish, 'Matthew');
      expect(bh.rawMedeb, 15);
      expect(bh.medeb, 15);
      expect(bh.wenber, 14);
      expect(bh.metqi, 26);
      expect(bh.abektie, 4);
      expect(bh.abektie + bh.metqi, 30);
      expect(bh.abushakir, 53);
    });

    test('Easter 2001 E.C. is ሚያዝያ 11 = 19 April 2009', () {
      final bh = BahireHasab(2001);
      expect(
        CalendarMath.gregorianFromJdn(bh.easterJdn),
        const GregorianDate(2009, 4, 19),
      );
      expect(
        CalendarMath.ethiopicFromJdn(bh.easterJdn),
        const EthiopicDate(2001, 8, 11),
      );
    });

    test('moveable chain matches the book dates and weekdays', () {
      final bh = BahireHasab(2001);
      void expectDay(String what, int jdn, EthiopicDate et, int weekday) {
        expect(CalendarMath.ethiopicFromJdn(jdn), et, reason: '$what date');
        expect(
          CalendarMath.weekdayIndex(jdn),
          weekday,
          reason: '$what weekday',
        );
      }

      expectDay(
        'Nineveh',
        bh.ninevehStartJdn,
        const EthiopicDate(2001, 6, 2),
        1,
      );
      expectDay(
        'Abiy Tsom',
        bh.abiyTsomStartJdn,
        const EthiopicDate(2001, 6, 16),
        1,
      );
      expectDay(
        'Debre Zeit',
        bh.debreZeitJdn,
        const EthiopicDate(2001, 7, 13),
        0,
      );
      expectDay('Hosanna', bh.hosannaJdn, const EthiopicDate(2001, 8, 4), 0);
      expectDay('Siklet', bh.sikletJdn, const EthiopicDate(2001, 8, 9), 5);
      expectDay('Easter', bh.easterJdn, const EthiopicDate(2001, 8, 11), 0);
      expectDay(
        'Rikbe Kahanat',
        bh.rikbeJdn,
        const EthiopicDate(2001, 9, 5),
        3,
      );
      expectDay('Erget', bh.ergetJdn, const EthiopicDate(2001, 9, 20), 4);
      expectDay(
        'Pentecost',
        bh.pentecostJdn,
        const EthiopicDate(2001, 9, 30),
        0,
      );
      expectDay(
        'Apostles',
        bh.hawaryatStartJdn,
        const EthiopicDate(2001, 10, 1),
        1,
      );
      expect(bh.hawaryatEndJdn, bh.jdnOf(11, 5)); // ends Hamle 5 (July 12).
    });

    // 2010 E.C. → Wenber 4, Abektie 14, Metqi 16 (Enkutatash ኀሙስ/Thursday).
    test('2010 E.C. book keys', () {
      final bh = BahireHasab(2010);
      expect(bh.wenber, 4);
      expect(bh.abektie, 14);
      expect(bh.metqi, 16);
      expect(bh.abektie + bh.metqi, 30);
      expect(
        CalendarMath.weekdayIndex(bh.jdnOf(1, 1)),
        1,
        reason: 'Enkutatash 2010 = 11 Sept 2017 (Monday)',
      );
    });

    test('Wenber × 11 ≡ 30 − Metqi for a broad range', () {
      for (var y = 1900; y <= 2100; y++) {
        final bh = BahireHasab(y);
        expect((bh.wenber * 11) % 30, bh.abektie, reason: 'Abektie in $y');
        expect(
          (bh.abektie + bh.metqi) % 30,
          0,
          reason: 'Abektie + Metqi ≡ 0 (mod 30) in $y',
        );
      }
    });
  });
}
