import 'package:flutter/material.dart';

import '../l10n.dart';
import '../widgets/app_drawer.dart';
import '../src/calendar_math.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool _ethiopicToGregorian = false;

  late int _gcYear;
  late int _gcMonth;
  late int _gcDay;

  late int _ecYear;
  late int _ecMonth;
  late int _ecDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _gcYear = now.year;
    _gcMonth = now.month;
    _gcDay = now.day;

    final et = CalendarMath.gregorianToEthiopic(
      GregorianDate(now.year, now.month, now.day),
    );
    _ecYear = et.year;
    _ecMonth = et.month;
    _ecDay = et.day;
  }

  static const List<String> _gregMonths = [
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

  int _gregDaysInMonth(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return CalendarMath.isGregorianLeap(year) ? 29 : 28;
    }
  }

  void _gcResetDay() {
    final maxDay = _gregDaysInMonth(_gcYear, _gcMonth);
    if (_gcDay > maxDay) _gcDay = maxDay;
  }

  void _ecResetDay() {
    final maxDay = CalendarMath.daysInEthiopicMonth(_ecYear, _ecMonth);
    if (_ecDay > maxDay) _ecDay = maxDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('ቀን መለወጫ', 'Date Converter'))),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: false,
                label: Text(L10n.t('ጎርጎርያን → ኢትዮጵያዊ', 'Gregorian → Ethiopian')),
                icon: const Icon(Icons.input),
              ),
              ButtonSegment(
                value: true,
                label: Text(L10n.t('ኢትዮጵያዊ → ጎርጎርያን', 'Ethiopian → Gregorian')),
                icon: const Icon(Icons.output),
              ),
            ],
            selected: {_ethiopicToGregorian},
            onSelectionChanged: (s) =>
                setState(() => _ethiopicToGregorian = s.first),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _ethiopicToGregorian
                  ? _ethiopicInput(context)
                  : _gregorianInput(context),
            ),
          ),
          const SizedBox(height: 16),
          _resultCard(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _gregorianInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.t('የጎርጎርያን ቀን አስገባ', 'Enter a Gregorian date'),
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        _dropdown(
          context,
          label: L10n.t('ወር', 'Month'),
          value: _gcMonth,
          items: [for (var m = 1; m <= 12; m++) _item(m, _gregMonths[m - 1])],
          onChanged: (v) => setState(() {
            _gcMonth = v;
            _gcResetDay();
          }),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _dropdown(
                context,
                label: L10n.t('ቀን', 'Day'),
                value: _gcDay,
                items: [
                  for (var d = 1; d <= _gregDaysInMonth(_gcYear, _gcMonth); d++)
                    _item(d, '$d'),
                ],
                onChanged: (v) => setState(() => _gcDay = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _yearField(_gcYear, (v) => _gcYear = v)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${L10n.t('ዓመት', 'Year')}: $_gcYear'),
            OutlinedButton.icon(
              onPressed: () {
                final now = DateTime.now();
                setState(() {
                  _gcYear = now.year;
                  _gcMonth = now.month;
                  _gcDay = now.day;
                });
              },
              icon: const Icon(Icons.event),
              label: Text(L10n.t('ዛሬ', 'Today')),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ethiopicInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.t('የኢትዮጵያ ቀን አስገባ', 'Enter an Ethiopian date'),
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        _dropdown(
          context,
          label: L10n.t('ወር', 'Month'),
          value: _ecMonth,
          items: [
            for (var m = 1; m <= 13; m++)
              _item(
                m,
                L10n.isAmharic
                    ? '${CalendarMath.ethiopicMonthAmharic[m - 1]} '
                          '(${CalendarMath.ethiopicMonthEnglish[m - 1]})'
                    : CalendarMath.ethiopicMonthEnglish[m - 1],
              ),
          ],
          onChanged: (v) => setState(() {
            _ecMonth = v;
            _ecResetDay();
          }),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _dropdown(
                context,
                label: L10n.t('ቀን', 'Day'),
                value: _ecDay,
                items: [
                  for (
                    var d = 1;
                    d <= CalendarMath.daysInEthiopicMonth(_ecYear, _ecMonth);
                    d++
                  )
                    _item(d, '$d'),
                ],
                onChanged: (v) => setState(() => _ecDay = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _yearField(_ecYear, (v) => _ecYear = v)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${L10n.t('ዓመት', 'Year')}: $_ecYear ${L10n.yearSuffix()}'),
            OutlinedButton.icon(
              onPressed: () {
                final now = DateTime.now();
                final et = CalendarMath.gregorianToEthiopic(
                  GregorianDate(now.year, now.month, now.day),
                );
                setState(() {
                  _ecYear = et.year;
                  _ecMonth = et.month;
                  _ecDay = et.day;
                });
              },
              icon: const Icon(Icons.event),
              label: Text(L10n.t('ዛሬ', 'Today')),
            ),
          ],
        ),
      ],
    );
  }

  DropdownMenuItem<int> _item(int value, String label) {
    return DropdownMenuItem(value: value, child: Text(label));
  }

  Widget _dropdown(
    BuildContext context, {
    required String label,
    required int value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int> onChanged,
  }) {
    return DropdownButtonFormField<int>(
      key: ValueKey('$label-$value'),
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      items: items,
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  Widget _yearField(int value, ValueChanged<int> onChanged) {
    return TextField(
      controller: TextEditingController(text: '$value'),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: L10n.t('ዓመት', 'Year'),
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      onSubmitted: (t) {
        final v = int.tryParse(t);
        if (v != null && v > 0) setState(() => onChanged(v));
      },
    );
  }

  Widget _resultCard(BuildContext context) {
    GregorianDate g;
    EthiopicDate e;
    int jdn;
    if (_ethiopicToGregorian) {
      e = EthiopicDate(_ecYear, _ecMonth, _ecDay);
      jdn = CalendarMath.jdnFromEthiopic(e.year, e.month, e.day);
      g = CalendarMath.gregorianFromJdn(jdn);
    } else {
      g = GregorianDate(_gcYear, _gcMonth, _gcDay);
      jdn = CalendarMath.jdnFromGregorian(g.year, g.month, g.day);
      e = CalendarMath.ethiopicFromJdn(jdn);
    }
    final wd = CalendarMath.weekdayIndex(jdn);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.t('ውጤት', 'Result'),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.calendar_month,
                color: Color(0xFF8C1F28),
              ),
              title: Text(
                L10n.t('ኢትዮጵያዊ', 'Ethiopian'),
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                '${e.day} ${L10n.monthName(e.month)} ${e.year} '
                '${L10n.yearSuffix()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event, color: Color(0xFF3E5C9A)),
              title: Text(
                L10n.t('ጎርጎርያን', 'Gregorian'),
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                '${_gregMonths[g.month - 1]} ${g.day}, ${g.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.calendar_today,
                color: Color(0xFF1E7A46),
              ),
              title: Text(
                L10n.t('የሳምንቱ ቀን', 'Weekday'),
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                L10n.weekdayName(wd),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              L10n.t('የጁሊያን ቀን ቁጥር: $jdn', 'Julian Day Number: $jdn'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
