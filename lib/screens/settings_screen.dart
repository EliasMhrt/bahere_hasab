import 'package:flutter/material.dart';

import '../app_preferences.dart';
import '../l10n.dart';
import '../notification_service.dart';
import '../theme_colors.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('ማስተካከያ', 'Settings'))),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: L10n.lang,
        builder: (context, lang, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _section(
                context,
                L10n.t('ቋንቋ', 'Language'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<AppLanguage>(
                      initialValue: L10n.lang.value,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: [
                        for (final language in AppLanguage.values)
                          DropdownMenuItem(
                            value: language,
                            child: Text(language.displayLabel),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) L10n.lang.value = value;
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      L10n.t(
                        'አዲሶቹ ትርጉሞች በማሽን የተዘጋጁ ናቸው፤ ማሻሻያ ሲያስፈልግ አማርኛ ይመልከቱ።',
                        'Newer translations are drafts and may need review; '
                            'Amharic and English are the reference versions.',
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.of(context).muted,
                      ),
                    ),
                  ],
                ),
              ),
              _section(
                context,
                L10n.t('የጽሁፍ መጠን', 'Text size'),
                SegmentedButton<AppTextScale>(
                  segments: [
                    ButtonSegment(
                      value: AppTextScale.small,
                      label: Text(L10n.t('ትንሽ', 'Small')),
                    ),
                    ButtonSegment(
                      value: AppTextScale.medium,
                      label: Text(L10n.t('መካከለኛ', 'Medium')),
                    ),
                    ButtonSegment(
                      value: AppTextScale.large,
                      label: Text(L10n.t('ትልቅ', 'Large')),
                    ),
                  ],
                  selected: {AppPrefs.textScale.value},
                  onSelectionChanged: (sel) =>
                      AppPrefs.textScale.value = sel.first,
                ),
              ),
              _section(
                context,
                L10n.t('መልክ (Theme)', 'Appearance'),
                SegmentedButton<AppThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: AppThemeMode.light,
                      label: Text(L10n.t('ብርሃን', 'Light')),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.dark,
                      label: Text(L10n.t('ጨለማ', 'Dark')),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.system,
                      label: Text(L10n.t('የስርዓቱን ተከተል', 'System')),
                    ),
                  ],
                  selected: {AppPrefs.themeMode.value},
                  onSelectionChanged: (sel) =>
                      AppPrefs.themeMode.value = sel.first,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: AppPrefs.highContrast,
                builder: (context, hc, _) {
                  return Card(
                    child: SwitchListTile(
                      title: Text(
                        L10n.t('ከፍተኛ ንጽጽር (High contrast)', 'High contrast'),
                      ),
                      subtitle: Text(
                        L10n.t(
                          'ቀለሞችን ለተሻለ ንባብ ያሻሽላል',
                          'Stronger colours for easier reading',
                        ),
                      ),
                      value: hc,
                      activeTrackColor: AppColors.of(context).primary,
                      onChanged: (v) => AppPrefs.highContrast.value = v,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: AppPrefs.reminder,
                builder: (context, reminder, _) {
                  return Card(
                    child: SwitchListTile(
                      title: Text(
                        L10n.t('የጾም ማስታወሻ', 'Fasting reminder'),
                      ),
                      subtitle: Text(
                        L10n.t(
                          'የአሁኑን የጾም ወቅትና ቀን በማሳወቂያ አሞሌ ላይ ያሳያል',
                          'Shows the current fasting season and date in the '
                              'notification bar',
                        ),
                      ),
                      value: reminder,
                      activeTrackColor: AppColors.of(context).primary,
                      onChanged: (value) async {
                        if (value) {
                          final granted = await NotificationService.enable();
                          AppPrefs.reminder.value = granted;
                          if (!granted && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  L10n.t(
                                    'ማሳወቂያ ፈቃድ አልተሰጠም።',
                                    'Notification permission was not granted.',
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          await NotificationService.disable();
                          AppPrefs.reminder.value = false;
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    L10n.t(
                      'ማስተካከያዎችዎ በመሣሪያዎ ውስጥ ብቻ ይቆያሉ፤ '
                          'ምንም መረጃ የሚደውጥም ወይም የሚልክ ነገር የለም።',
                      'Your preferences stay on your device only — nothing is '
                          'recorded or sent anywhere.',
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.of(context).muted,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _section(BuildContext context, String title, Widget child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
