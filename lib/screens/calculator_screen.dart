import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme_colors.dart';
import '../widgets/app_drawer.dart';
import '../src/bahire_hasab.dart';
import '../src/calendar_math.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late int _year;

  static const int _minYear = 1700;
  static const int _maxYear = 2300;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final et = CalendarMath.gregorianToEthiopic(
      GregorianDate(now.year, now.month, now.day),
    );
    _year = et.year;
  }

  @override
  Widget build(BuildContext context) {
    final bh = BahireHasab(_year);
    final enkutatash = CalendarMath.gregorianFromJdn(bh.enkutatashJdn);
    final enkutatashWeekday = CalendarMath.weekdayIndex(bh.enkutatashJdn);

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t('የባህረ ሃሳብ ሂሳብ', 'Bahire Hasab calculator')),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _yearSelector(context),
          const SizedBox(height: 16),
          _valuesSection(context, bh, enkutatash, enkutatashWeekday),
          const SizedBox(height: 20),
          _stepByStepSection(context, bh),
          const SizedBox(height: 20),
          _moveableSection(context, bh),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _yearSelector(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              L10n.t('ዓመተ ምህረት', 'Ethiopian year'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _year > _minYear
                      ? () => setState(() => _year--)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    key: ValueKey('year-$_year'),
                    initialValue: _year,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: [
                      for (var y = _minYear; y <= _maxYear; y++)
                        DropdownMenuItem(
                          value: y,
                          child: Text('$y ${L10n.yearSuffix()}'),
                        ),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _year = v);
                    },
                  ),
                ),
                IconButton(
                  onPressed: _year < _maxYear
                      ? () => setState(() => _year++)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Wrap(
              spacing: 6,
              children: [
                for (final y in [_year - 1, _year, _year + 1, _year + 5])
                  ActionChip(
                    label: Text('$y ${L10n.yearSuffix()}'),
                    onPressed: () => setState(() => _year = y),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _valuesSection(
    BuildContext context,
    BahireHasab bh,
    GregorianDate enkutatash,
    int wd,
  ) {
    final rows = <(String, String, String)>[
      ('ዓመተ ዓለም', 'Amete Alem (years since creation)', '${bh.ameteAlem}'),
      ('መጠነ ራብዒት', 'Matene Rabiet (Amete Alem ÷ 4)', '${bh.mateneRabiet}'),
      ('ወንጌላዊ', 'Evangelist of the year', L10n.evangelistName(bh)),
      ('መደብ', 'Medeb (Amete Alem ÷ 19)', '${bh.medeb}'),
      ('ወንበር', 'Wenber (seat in the cycle)', '${bh.wenber}'),
      ('አበቅቴ', 'Abektie (lunar epact)', '${bh.abektie}'),
      ('መጥቅዕ', 'Metqi (lunar key number)', '${bh.metqi}'),
      ('አቡሻኪር', 'Abushakir (532-year Paschal cycle)', '${bh.abushakir}'),
      (
        'ጳጉሜ',
        'Pagume days at the end of the year',
        bh.isLeap
            ? L10n.t('6 ቀናት (የጳጉሜ ዓመት)', '6 days (leap year)')
            : L10n.t('5 ቀናት', '5 days'),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.tp(
                'የዓመቱ ቁጥሮች ({year} {suffix})',
                'The year\'s numbers ({year} {suffix})',
                {'year': _year, 'suffix': L10n.yearSuffix()},
              ),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              L10n.tp(
                'እንቁጣጣሽ (አዲስ ዓመት): {date}',
                'Enkutatash (Ethiopian New Year): {date}',
                {
                  'date':
                      '${enkutatash.year}-${enkutatash.month}-${enkutatash.day}',
                },
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            for (final (nameAm, nameEn, value) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        L10n.t(nameAm, nameEn),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          color: AppColors.of(context).muted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              L10n.t(
                'ምስጢር ማለት የሒሳቡ የተደበቀ እውቀት ማለት ነው። ወንበር '
                'ዓመቱን በ19 ዓመት ዑደት ውስጥ ያስቀምጣል፣ አበቅቴና '
                'መጥቅዕ ከእርሱ ይወጣሉ፤ አበቅቴ + መጥቅዕ = 30 '
                'መውጣት አለበት። ከነነዌ ጀምሮ ፋሲካና ሌሎቹ '
                'ተንቀሳቃሽ በዓላት ይቆጠራሉ።',
                'ምስጢር (Mister) means the hidden knowledge of the '
                'reckoning itself. Wenber places the year in the 19-year '
                'cycle; Abektie and Metqi are derived from it, and '
                'Abektie + Metqi always = 30. From Nineveh the church '
                'counts Easter and all the moveable feasts.',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepByStepSection(BuildContext context, BahireHasab bh) {
    final year = bh.year;
    final aa = bh.ameteAlem;
    final rawW = bh.rawMedeb;
    final w = bh.wenber;
    final ab = bh.abektie;
    final metqi = bh.metqi;
    final metkMonth = metqi > 14 ? 1 : 2;
    final metkName = L10n.monthName(metkMonth);
    final metkWd = CalendarMath.weekdayIndex(bh.jdnOf(metkMonth, metqi));
    final wdName = L10n.weekdayName(metkWd);
    final tewsak = _tewsakOf(metkWd);
    final mhSum = metqi + tewsak;
    final mh = mhSum > 30 ? mhSum - 30 : mhSum;
    final nenewe = CalendarMath.ethiopicFromJdn(bh.ninevehStartJdn);

    final feasts = <(String, String, int, int)>[
      ('ጾመ ነነዌ', 'Tsome Nenewe (Fast of Nineveh)', 0, bh.ninevehStartJdn),
      ('ዐቢይ ጾም', 'Abiy Tsom (Great Lent)', 14, bh.abiyTsomStartJdn),
      ('ደብረ ዘይት', 'Debre Zeyit (Mid-Lent)', 11, bh.debreZeitJdn),
      ('ሆሣዕና', 'Hosanna (Palm Sunday)', 2, bh.hosannaJdn),
      ('ስቅለት', 'Siklet (Good Friday)', 7, bh.sikletJdn),
      ('ትንሣኤ (ፋሲካ)', 'Tinsae (Easter)', 9, bh.easterJdn),
      ('ረክበ ካህናት', 'Rekbe Kahanat', 3, bh.rikbeJdn),
      ('ዕርገት', 'Erget (Ascension)', 18, bh.ergetJdn),
      ('ጰራቅሎጦስ', 'Peraqlitos (Pentecost)', 28, bh.pentecostJdn),
      if (bh.hasHawaryatFast)
        ('ጾመ ሐዋርያት', 'Tsome Hawaryat (Apostles)', 29, bh.hawaryatStartJdn),
      ('ጾመ ድኅነት', 'Tsome Dihnet (Salvation)', 1, bh.dihnetStartJdn),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.tp(
                'የሒሳቡ ስሌት እርምጃ በእርምጃ ({year} {suffix})',
                'Step-by-step calculation ({year} {suffix})',
                {'year': _year, 'suffix': L10n.yearSuffix()},
              ),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              L10n.t(
                'ስሌቱ 7 እርምጃ ይዟል፤ ውጤቱ '
                    'ከታች ካለው የበዓላት ዝርዝር ጋር ይጣጣማል።',
                'The book\'s worked example is reproduced, step by step. '
                    'The results match the feast list below.',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            _stepTitle(
              1,
              L10n.t('ዓመተ ዓለምን ማውጣት', 'Step 1 · Find the Era of the World'),
            ),
            _bullet(
              L10n.t(
                'ዓመተ ዓለም = ዓመተ ምሕረት + 5500',
                'Amete Alem = Amete Mihret + 5500',
              ),
            ),
            _result('$year + 5500 = $aa'),
            const Divider(height: 20),
            _stepTitle(2, L10n.t('መደብን ማውጣት', 'Step 2 · Find the Medeb')),
            _bullet(
              L10n.t(
                'መደብ = ዓመተ ዓለምን በ19 ስንካፈል የሚቀረው ቀሪ',
                'Medeb = the remainder when Amete Alem is divided by 19',
              ),
            ),
            _result(
              L10n.tp(
                '{a} ÷ 19 = {q} ቀሪ {r}',
                '{a} ÷ 19 = {q} remainder {r}',
                {'a': aa, 'q': aa ~/ 19, 'r': rawW},
              ),
            ),
            _result(
              rawW == 0
                  ? L10n.t(
                      'ቀሪው 0 ስለሆነ መደብ = 19 (0 → 19)',
                      'Since the remainder is 0, Medeb = 19 (0 maps to 19)',
                    )
                  : L10n.tp('መደብ = {v}', 'Medeb = {v}', {'v': rawW}),
            ),
            const Divider(height: 20),
            _stepTitle(3, L10n.t('ወንበርን ማውጣት', 'Step 3 · Find the Wenber')),
            _bullet(L10n.t('ወንበር = መደብ − 1', 'Wenber = Medeb − 1')),
            _result(
              rawW == 0
                  ? L10n.t('ወንበር = 19 − 1 = 18', 'Wenber = 19 − 1 = 18')
                  : L10n.tp(
                      'ወንበር = {a} − 1 = {b}',
                      'Wenber = {a} − 1 = {b}',
                      {'a': rawW, 'b': w},
                    ),
            ),
            const Divider(height: 20),
            _stepTitle(
              4,
              L10n.t('አበቅቴና መጥቅዕን ማውጣት', 'Step 4 · Find the Abektie and Metqi'),
            ),
            _bullet(
              L10n.t(
                'አበቅቴ = ወንበርን በ11 በማባዛት፣ ውጤቱን በ30 ስንካፈል '
                    'የሚቀረው ቀሪ',
                'Abektie = the remainder when Wenber × 11 is divided by 30',
              ),
            ),
            _result(
              L10n.tp(
                '({a} × 11) = {b} → በ30 ስንካፈል የሚቀረው ቀሪ {c}',
                '({a} × 11) = {b} → the remainder when divided by 30 is {c}',
                {'a': w, 'b': w * 11, 'c': ab},
              ),
            ),
            _bullet(
              L10n.t(
                'መጥቅዕ = ወንበርን በ19 በማባዛት፣ ውጤቱን በ30 ስንካፈል '
                    'የሚቀረው ቀሪ',
                'Metqi = the remainder when Wenber × 19 is divided by 30',
              ),
            ),
            _result(
              L10n.tp(
                '({a} × 19) = {b} → በ30 ስንካፈል የሚቀረው ቀሪ {c}',
                '({a} × 19) = {b} → the remainder when divided by 30 is {c}',
                {'a': w, 'b': w * 19, 'c': metqi},
              ),
            ),
            _result(
              L10n.tp(
                'ማረጋገጫ፡ አበቅቴ + መጥቅዕ = {a} + {b} = {c} ✓',
                'Check: Abektie + Metqi = {a} + {b} = {c} ✓',
                {'a': ab, 'b': metqi, 'c': ab + metqi},
              ),
            ),
            const Divider(height: 20),
            _stepTitle(
              4,
              L10n.t('የመጥቅዕን ወር መለየት', 'Step 5 · Locate the Metqi month'),
            ),
            _bullet(
              L10n.t(
                'ከ14 በላይ ያለ መጥቅዕ በመስከረም፣ ከ14 በታች ያለ'
                    ' መጥቅዕ በጥቅምት ይውላል',
                'A Metqi greater than 14 falls in Meskerem; a Metqi '
                    'of 14 or less falls in Tikimt',
              ),
            ),
            _result(
              metqi > 14
                  ? L10n.tp(
                      'መጥቅዕ = {m} > 14 ስለሆነ በመስከረም ይውላል → {n} {m}',
                      'Metqi = {m} > 14 so it falls in Meskerem → {n} {m}',
                      {'m': metqi, 'n': metkName},
                    )
                  : L10n.tp(
                      'መጥቅዕ = {m} ≤ 14 ስለሆነ በጥቅምት ይውላል → {n} {m}',
                      'Metqi = {m} ≤ 14 so it falls in Tikimt → {n} {m}',
                      {'m': metqi, 'n': metkName},
                    ),
            ),
            const Divider(height: 20),
            _stepTitle(
              5,
              L10n.t(
                'የዕለት ተውሳክና መባጃ ሐመር',
                'Step 6 · The Tewsak and the Mebaja Hamer',
              ),
            ),
            _bullet(
              L10n.tp(
                '{n} {m} በ{wd} ነው የሚውለው',
                '{n} {m} falls on {wd}',
                {'n': metkName, 'm': metqi, 'wd': wdName},
              ),
            ),
            _result(
              L10n.tp(
                'የ{wd} ተውሳክ = {t}',
                'Tewsak of {wd} = {t}',
                {'wd': wdName, 't': tewsak},
              ),
            ),
            _bullet(
              L10n.t(
                'መባጃ ሐመር = መጥቅዕ + የዕለቱ ተውሳክ (ከ30 በለ ቀንስ)',
                'Mebaja Hamer = Metqi + Tewsak (subtract 30 if over)',
              ),
            ),
            _result(
              mhSum > 30
                  ? L10n.tp(
                      'መባጃ ሐመር = {m} + {t} = {s} − 30 = {r}',
                      'Mebaja Hamer = {m} + {t} = {s} − 30 = {r}',
                      {'m': metqi, 't': tewsak, 's': mhSum, 'r': mh},
                    )
                  : L10n.tp(
                      'መባጃ ሐመር = {m} + {t} = {r}',
                      'Mebaja Hamer = {m} + {t} = {r}',
                      {'m': metqi, 't': tewsak, 'r': mh},
                    ),
            ),
            _result(
              L10n.tp(
                'ስለዚህ ጾመ ነነዌ በ{month} {day} ይገባል።',
                'So Tsome Nenewe starts on {month} {day}.',
                {'month': L10n.monthName(nenewe.month), 'day': nenewe.day},
              ),
            ),
            const Divider(height: 20),
            _stepTitle(
              6,
              L10n.t('ተንቀሳቃሽ በዓላትን ማውጣት', 'Step 7 · The moveable feasts'),
            ),
            _bullet(
              L10n.tp(
                'የየበዓሉ ተውሳክ ወደ መባጃ ሐመር ({mh}) ተደምሮ፣ ከ30 በላይ '
                'ሲሆን 30 ቀንሶ ወደ ቀጠለው ወር ይሸጋገራል።',
                'Add each feast\'s Tewsak to the Mebaja Hamer ({mh}); when the '
                'sum exceeds 30, subtract 30 and roll into the next month.',
                {'mh': mh},
              ),
            ),
            const SizedBox(height: 8),
            for (final (nameAm, nameEn, tw, jdn) in feasts)
              _feastRow(nameAm, nameEn, mh, tw, jdn),
          ],
        ),
      ),
    );
  }

  Widget _stepTitle(int n, String title) {
    final c = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: c.primary,
            child: Text(
              '$n',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: c.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String line) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, right: 6),
            child: Text('•', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
          Expanded(child: Text(line, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _result(String line) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              line,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.of(context).primary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feastRow(String nameAm, String nameEn, int mh, int tw, int jdn) {
    final sum = mh + tw;
    final et = CalendarMath.ethiopicFromJdn(jdn);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.t(nameAm, nameEn),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          Text(
            sum > 30
                ? L10n.t(
                    'መባጃ ሐመር $mh + ተውሳክ $tw = $sum − 30 = ${sum - 30}',
                    'Mebaja Hamer $mh + Tewsak $tw = $sum − 30 = ${sum - 30}',
                  )
                : L10n.t(
                    'መባጃ ሐመር $mh + ተውሳክ $tw = $sum',
                    'Mebaja Hamer $mh + Tewsak $tw = $sum',
                  ),
            style: TextStyle(
              fontSize: 12,
              color: AppColors.of(context).muted,
            ),
          ),
          Text(
            '→ ${et.day} ${L10n.monthName(et.month)} ${L10n.yearSuffix()}',
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static int _tewsakOf(int weekdayIndex) =>
      weekdayIndex == 6 ? 8 : 7 - weekdayIndex;

  Widget _moveableSection(BuildContext context, BahireHasab bh) {
    final c = AppColors.of(context);
    final rows = <(String, String, String, bool)>[
      (
        'ጾመ ነነዌ',
        'Fast of Nineveh',
        _longRange1(bh, bh.ninevehStartJdn, bh.ninevehEndJdn),
        false,
      ),
      (
        'ዐቢይ ጾም',
        'Great Lent (Hudade)',
        _longRange1(bh, bh.abiyTsomStartJdn, bh.abiyTsomEndJdn),
        true,
      ),
      ('ደብረ ዘይት', 'Mid-Lent Sunday', _longRange0(bh, bh.debreZeitJdn), false),
      ('ሆሳዕና', 'Hosanna (Palm Sunday)', _longRange0(bh, bh.hosannaJdn), false),
      ('ስቅለት', 'Siklet (Good Friday)', _longRange0(bh, bh.sikletJdn), true),
      ('ፋሲካ', 'Fasika (Easter)', _longRange0(bh, bh.easterJdn), true),
      (
        'ርክበ ካህናት',
        'Rikbe Kahanat (Priests\' Assembly)',
        _longRange0(bh, bh.rikbeJdn),
        false,
      ),
      ('ዕርገት', 'Erget (Ascension)', _longRange0(bh, bh.ergetJdn), true),
      (
        'ጰራቅሊጦስ',
        'Peraqlitos (Pentecost)',
        _longRange0(bh, bh.pentecostJdn),
        true,
      ),
      if (bh.hasHawaryatFast)
        (
          'ጾመ ሐዋርያት',
          'Fast of the Apostles',
          _longRange1(bh, bh.hawaryatStartJdn, bh.hawaryatEndJdn),
          false,
        ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.tp(
                'ተንቀሳቃሽ በዓላት ({year} {suffix})',
                'Moveable feasts ({year} {suffix})',
                {'year': _year, 'suffix': L10n.yearSuffix()},
              ),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            for (final (title, subtitle, range, major) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (major)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.star,
                          color: c.majorFeast,
                          size: 18,
                        ),
                      )
                    else
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            L10n.t(title, subtitle),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            range,
                            style: TextStyle(
                              fontSize: 12,
                              color: c.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _longRange0(BahireHasab bh, int jdn) {
    final et = CalendarMath.ethiopicFromJdn(jdn);
    final g = CalendarMath.gregorianFromJdn(jdn);
    return '${et.day} ${L10n.monthName(et.month)} '
        '${L10n.yearSuffix()} · $g';
  }

  String _longRange1(BahireHasab bh, int startJdn, int endJdn) {
    final s = CalendarMath.ethiopicFromJdn(startJdn);
    final e = CalendarMath.ethiopicFromJdn(endJdn);
    final gs = CalendarMath.gregorianFromJdn(startJdn);
    final ge = CalendarMath.gregorianFromJdn(endJdn);
    return '${s.day} ${L10n.monthName(s.month)} – '
        '${e.day} ${L10n.monthName(e.month)} '
        '${L10n.yearSuffix()} · $gs – $ge';
  }
}
