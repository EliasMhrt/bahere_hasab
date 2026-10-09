import 'package:flutter/material.dart';

import '../l10n.dart';
import '../share_service.dart';
import '../theme_colors.dart';
import '../src/bahire_hasab.dart';
import '../src/calendar_math.dart';
import '../src/festivals.dart';
import 'calendar_screen.dart';
import 'calculator_screen.dart';
import 'converter_screen.dart';
import 'education_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _todayJdn;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _todayJdn = CalendarMath.jdnFromGregorian(now.year, now.month, now.day);
  }

  String get _formattedEthiopicDate {
    final et = CalendarMath.ethiopicFromJdn(_todayJdn);
    return '${et.day} ${L10n.monthName(et.month)} ${et.year} ${L10n.yearSuffix()}';
  }

  void _open(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final et = CalendarMath.ethiopicFromJdn(_todayJdn);
    final bh = BahireHasab(et.year);
    final weekday = CalendarMath.weekdayIndex(_todayJdn);
    final status = Festivals.fastStatusOnJdn(_todayJdn);
    final season = Festivals.fastingSeasonOnJdn(_todayJdn);
    final events = Festivals.eventsForYear(et.year);
    final todaysEvents = Festivals.eventsOnJdn(
      events,
      _todayJdn,
    ).where((e) => e.isMajor).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('ባህረ ሃሳብ'),
            Text(
              L10n.t(
                'የኢትዮጵያ ቤተክርስቲያን የቀን አቆጣጠር',
                'Bahire Hasab · Ethiopian Calendar',
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: L10n.t('መተግበሪያውን አጋራ', 'Share app'),
            icon: const Icon(Icons.share),
            onPressed: ShareService.shareApp,
          ),
          IconButton(
            tooltip: L10n.t('ወደ እንግሊዝኛ', 'አማርኛ'),
            icon: const Icon(Icons.translate),
            onPressed: () {
              L10n.lang.value = L10n.isAmharic
                  ? AppLanguage.english
                  : AppLanguage.amharic;
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.today, color: c.primary),
                      const SizedBox(width: 8),
                      Text(
                        L10n.t('ዛሬ', 'Today'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _formattedEthiopicDate,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: c.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${L10n.weekdayName(weekday)} · '
                    '${L10n.t('የዓመቱ መመለሻ', 'Year')} ${et.year} '
                    '${L10n.yearSuffix()} (${L10n.eraName()})',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  _statusChip(status, season),
                  if (todaysEvents.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      todaysEvents
                          .map(
                            (e) => L10n.isAmharic
                                ? '${e.title} (${e.subtitle})'
                                : L10n.eventName(e),
                          )
                          .join(' · '),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: c.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${L10n.t('ወንበር', 'Wenber')}: ${bh.wenber} · '
                    '${L10n.t('አበቅቴ', 'Abektie')}: ${bh.abektie} · '
                    '${L10n.t('መጥቅዕ', 'Metqi')}: ${bh.metqi} · '
                    '${L10n.t('ወንጌላዊ', 'Evangelist')}: '
                    '${L10n.evangelistName(bh)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _featureCard(
            context,
            icon: Icons.calendar_month,
            title: L10n.t('ጾምና በዓላት', 'Festival & Fasting Calendar'),
            subtitle: L10n.t('በዓላትና የጾም ቀናት', 'Festivals and fasting days'),
            onTap: () => _open(const CalendarScreen()),
          ),
          _featureCard(
            context,
            icon: Icons.calculate,
            title: L10n.t('የባህረ ሃሳብ ሂሳብ', 'Bahire Hasab Calculator'),
            subtitle: L10n.t(
              'የዓመቱ ቁጥሮችና በዓላት',
              'The year\'s numbers and feasts',
            ),
            onTap: () => _open(const CalculatorScreen()),
          ),
          _featureCard(
            context,
            icon: Icons.swap_horiz,
            title: L10n.t('ቀን መለወጫ', 'Date Converter'),
            subtitle: L10n.t('ኢትዮጵያዊና ጎርጎርያን', 'Ethiopian ⇄ Gregorian'),
            onTap: () => _open(const ConverterScreen()),
          ),
          _featureCard(
            context,
            icon: Icons.menu_book,
            title: L10n.t('ትምህርት', 'Learn'),
            subtitle: L10n.t('ስለ ባህረ ሃሳብ', 'How Bahire Hasab works'),
            onTap: () => _open(const EducationScreen()),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              L10n.t('በ ኦርያሬስ የተሰራ', 'Developed by Oryares'),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.2,
                color: c.faint,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              L10n.t('© ኦርያሬስ', '© Oryares'),
              style: TextStyle(fontSize: 11, color: c.faint),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _statusChip(FastStatus status, FastingSeason? season) {
    final c = AppColors.of(context);
    String label;
    IconData icon;
    Color color;
    switch (status) {
      case FastStatus.seasonal:
        label = season != null
            ? L10n.seasonName(season)
            : L10n.t('የጾም ወቅት', 'Full fasting season');
        icon = Icons.fastfood;
        color = c.fasting;
        break;
      case FastStatus.weekly:
        label = L10n.t('ሳምንታዊ ጾም (ረቡዕ/ዓርብ)', 'Wednesday/Friday fast');
        icon = Icons.filter_drama;
        color = c.weeklyFast;
        break;
      case FastStatus.none:
        label = L10n.t('በዓል / ጾም የለም', 'No fasting today');
        icon = Icons.celebration;
        color = c.noFast;
        break;
    }
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.4)),
    );
  }

  Widget _featureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final c = AppColors.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: c.primary.withValues(alpha: 0.15),
          child: Icon(icon, color: c.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
