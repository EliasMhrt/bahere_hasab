import 'package:flutter/material.dart';

import '../l10n.dart';
import '../widgets/app_drawer.dart';
import '../src/bahire_hasab.dart';
import '../src/calendar_math.dart';
import '../src/festivals.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int _year;
  late int _month;
  late int _todayJdn;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _todayJdn = CalendarMath.jdnFromGregorian(now.year, now.month, now.day);
    final et = CalendarMath.ethiopicFromJdn(_todayJdn);
    _year = et.year;
    _month = et.month;
  }

  void _prevMonth() {
    setState(() {
      if (_month == 1) {
        _month = 13;
        _year--;
      } else {
        _month--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_month == 13) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
    });
  }

  void _goToday() {
    final et = CalendarMath.ethiopicFromJdn(_todayJdn);
    setState(() {
      _year = et.year;
      _month = et.month;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bh = BahireHasab(_year);
    final monthStartJdn = bh.jdnOf(_month, 1);
    final days = bh.daysInMonth(_month);
    final monthEndJdn = bh.jdnOf(_month, days);
    final startWeekday = CalendarMath.weekdayIndex(monthStartJdn);
    final yearEvents = Festivals.eventsForYear(_year);

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t('ጾምና በዓላት', 'Festival & fasting calendar')),
        actions: [
          IconButton(
            tooltip: L10n.t('ወደ ዛሬ', 'Go to today'),
            icon: const Icon(Icons.today),
            onPressed: _goToday,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _monthHeader(context),
          const SizedBox(height: 8),
          _weekdayHeader(),
          const SizedBox(height: 4),
          _monthGrid(context, monthStartJdn, days, startWeekday),
          const SizedBox(height: 12),
          _legend(),
          const SizedBox(height: 16),
          Text(
            L10n.t('የወሩ በዓላትና ጾም', 'Events this month'),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._monthEvents(context, monthStartJdn, monthEndJdn, yearEvents),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _monthHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: _prevMonth, icon: const Icon(Icons.chevron_left)),
        Expanded(
          child: Column(
            children: [
              Text(
                '${L10n.monthName(_month)} $_year ${L10n.yearSuffix()}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${L10n.monthName(_month)} · '
                '${L10n.t('ጎርጎርያን', 'Gregorian')}: '
                '${_gregorianRange(_year, _month)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _nextMonth,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  String _gregorianRange(int year, int month) {
    final bh = BahireHasab(year);
    final start = CalendarMath.gregorianFromJdn(bh.jdnOf(month, 1));
    final end = CalendarMath.gregorianFromJdn(
      bh.jdnOf(month, bh.daysInMonth(month)),
    );
    String fmd(int m) => m < 10 ? '0$m' : '$m';
    return '${fmd(start.month)}/${fmd(start.day)} – ${fmd(end.month)}/${fmd(end.day)}';
  }

  Widget _weekdayHeader() {
    final labels = [for (var i = 0; i < 7; i++) L10n.weekdayShort(i)];
    return Row(
      children: [
        for (final label in labels)
          Expanded(
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6E4B12),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _monthGrid(
    BuildContext context,
    int monthStartJdn,
    int days,
    int startWeekday,
  ) {
    final bh = BahireHasab(_year);
    final yearEvents = Festivals.eventsForYear(_year);
    final totalCells = startWeekday + days;
    final rows = ((totalCells + 6) ~/ 7);

    final rowsWidgets = <Widget>[];
    for (var week = 0; week < rows; week++) {
      final rowCells = <Widget>[];
      for (var col = 0; col < 7; col++) {
        final cellIndex = week * 7 + col;
        if (cellIndex < startWeekday) {
          rowCells.add(const Expanded(child: SizedBox(height: 54)));
          continue;
        }
        final day = cellIndex - startWeekday + 1;
        if (day > days) {
          rowCells.add(const Expanded(child: SizedBox(height: 54)));
          continue;
        }
        final jdn = bh.jdnOf(_month, day);
        final greg = CalendarMath.gregorianFromJdn(jdn);
        final events = Festivals.eventsOnJdn(yearEvents, jdn);
        final majorFeastCount = events
            .where(
              (e) =>
                  e.isMajor &&
                  (e.kind == EventKind.fixedFeast ||
                      e.kind == EventKind.moveableFeast),
            )
            .length;
        final anyFeastCount = events
            .where(
              (e) =>
                  e.kind == EventKind.fixedFeast ||
                  e.kind == EventKind.moveableFeast,
            )
            .length;
        final status = Festivals.fastStatusOnJdn(jdn);

        rowCells.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: _DayCell(
                day: day,
                gregDay: greg.day,
                isToday: jdn == _todayJdn,
                isMajorFeast: majorFeastCount > 0,
                isFeast: majorFeastCount == 0 && anyFeastCount > 0,
                status: status,
                onTap: () => _showDayDetails(jdn),
              ),
            ),
          ),
        );
      }
      rowsWidgets.add(Row(children: rowCells));
    }

    return Column(children: rowsWidgets);
  }

  void _showDayDetails(int jdn) {
    final et = CalendarMath.ethiopicFromJdn(jdn);
    final greg = CalendarMath.gregorianFromJdn(jdn);
    final bh = BahireHasab(et.year);
    final weekday = CalendarMath.weekdayIndex(jdn);
    final events = Festivals.eventsOnJdn(Festivals.eventsForYear(et.year), jdn);
    final status = Festivals.fastStatusOnJdn(jdn);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        String statusText;
        Color statusColor;
        switch (status) {
          case FastStatus.seasonal:
            statusText = L10n.t('በጾም ወቅት ውስጥ ነው', 'In a fasting season');
            statusColor = const Color(0xFF8C1F28);
            break;
          case FastStatus.weekly:
            statusText = L10n.t('ሳምንታዊ ጾም (ረቡዕ/ዓርብ)', 'Wednesday/Friday fast');
            statusColor = const Color(0xFF3E5C9A);
            break;
          case FastStatus.none:
            statusText = L10n.t('የጾም ቀን አይደለም', 'Not a fasting day');
            statusColor = const Color(0xFF1E7A46);
            break;
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${et.day} ${L10n.monthName(et.month)} ${et.year} '
                '${L10n.yearSuffix()}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '${greg.year}-${greg.month}-${greg.day} '
                '(${L10n.t('ጎርጎርያን', 'Gregorian')}) · '
                '${L10n.weekdayName(weekday)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Chip(
                avatar: Icon(
                  status == FastStatus.none
                      ? Icons.celebration
                      : Icons.fastfood,
                  size: 18,
                  color: statusColor,
                ),
                label: Text(statusText),
                backgroundColor: statusColor.withValues(alpha: 0.1),
                side: BorderSide(color: statusColor.withValues(alpha: 0.4)),
              ),
              if (events.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  L10n.t('በዚህ ቀን የሚከበሩት', 'Celebrated on this day'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                for (final e in events)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      e.isMajor
                          ? Icons.star
                          : (e.kind == EventKind.fasting
                                ? Icons.fastfood
                                : Icons.circle),
                      color: e.isMajor
                          ? const Color(0xFFB8860B)
                          : const Color(0xFF8C1F28),
                    ),
                    title: Text(
                      L10n.eventName(e),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(L10n.eventSecondary(e)),
                    dense: true,
                  ),
              ],
              const SizedBox(height: 8),
              Text(
                L10n.isAmharic
                    ? 'ባህረ ሃሳብ: መደብ ${bh.medeb} · ወንበር '
                          '${bh.wenber} · አበቅቴ ${bh.abektie} · '
                          'መጥቅዕ ${bh.metqi}'
                    : 'Bahire Hasab: medeb ${bh.medeb} · wenber '
                          '${bh.wenber} · abektie ${bh.abektie} · '
                          'metqi ${bh.metqi}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _legend() {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: [
        _legendItem(const Color(0xFFB8860B), L10n.t('በዓል', 'Major feast')),
        _legendItem(const Color(0xFFD9A441), L10n.t('በዓል', 'Feast')),
        _legendItem(
          const Color(0xFF8C1F28),
          L10n.t('የጾም ወቅት', 'Fasting season'),
        ),
        _legendItem(
          const Color(0xFF3E5C9A),
          L10n.t('ረቡዕ/ዓርብ ጾም', 'Wed/Fri fast'),
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  List<Widget> _monthEvents(
    BuildContext context,
    int monthStartJdn,
    int monthEndJdn,
    List<CalendarEvent> yearEvents,
  ) {
    final relevant = yearEvents.where((e) {
      final intersects = e.startJdn <= monthEndJdn && e.endJdn >= monthStartJdn;
      return intersects &&
          (e.kind == EventKind.fixedFeast ||
              e.kind == EventKind.moveableFeast ||
              e.kind == EventKind.fasting);
    }).toList();

    if (relevant.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            L10n.t(
              'በዚህ ወር ምንም ዋና በዓል ወይም ጾም የለም',
              'No major feast or fast this month',
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ];
    }

    return [for (final e in relevant) _EventTile(event: e)];
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final int gregDay;
  final bool isToday;
  final bool isMajorFeast;
  final bool isFeast;
  final FastStatus status;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.gregDay,
    required this.isToday,
    required this.isMajorFeast,
    required this.isFeast,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color background = Colors.transparent;
    Color borderColor = const Color(0xFFFFE9C9);

    if (isMajorFeast) {
      background = const Color(0xFFB8860B).withValues(alpha: 0.28);
      borderColor = const Color(0xFFB8860B);
    } else if (isFeast) {
      background = const Color(0xFFD9A441).withValues(alpha: 0.35);
      borderColor = const Color(0xFFD9A441);
    } else if (status == FastStatus.seasonal) {
      background = const Color(0xFF8C1F28).withValues(alpha: 0.10);
    } else if (status == FastStatus.weekly) {
      background = const Color(0xFF3E5C9A).withValues(alpha: 0.12);
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isToday ? const Color(0xFF8C1F28) : borderColor,
              width: isToday ? 2 : 1,
            ),
          ),
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isMajorFeast
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isMajorFeast
                            ? const Color(0xFF8C1F28)
                            : Colors.black87,
                      ),
                    ),
                    Text(
                      '$gregDay',
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (isMajorFeast)
                const Positioned(
                  top: 3,
                  right: 3,
                  child: Icon(Icons.star, size: 10, color: Color(0xFFB8860B)),
                )
              else if (isFeast)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9A441),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final CalendarEvent event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    final startEt = CalendarMath.ethiopicFromJdn(event.startJdn);
    final endEt = CalendarMath.ethiopicFromJdn(event.endJdn);
    final isFasting = event.kind == EventKind.fasting;

    IconData icon;
    Color color;
    if (isFasting) {
      icon = Icons.fastfood;
      color = const Color(0xFF8C1F28);
    } else if (event.isMajor) {
      icon = Icons.star;
      color = const Color(0xFFB8860B);
    } else {
      icon = Icons.circle;
      color = const Color(0xFFD9A441);
    }

    String range;
    if (event.isSingleDay) {
      range =
          '${startEt.day} ${L10n.monthName(startEt.month)} '
          '${L10n.yearSuffix()} (${_gregShort(startEt)})';
    } else {
      range =
          '${startEt.day} ${L10n.monthName(startEt.month)} – '
          '${endEt.day} ${L10n.monthName(endEt.month)} '
          '${L10n.yearSuffix()} (${_gregShort(startEt)} – ${_gregShort(endEt)})';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          L10n.eventName(event),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('${L10n.eventSecondary(event)} · $range'),
      ),
    );
  }

  String _gregShort(EthiopicDate et) {
    final g = CalendarMath.ethiopicToGregorian(et);
    String fmd(int m) => m < 10 ? '0$m' : '$m';
    return '${fmd(g.month)}/${fmd(g.day)}';
  }
}
