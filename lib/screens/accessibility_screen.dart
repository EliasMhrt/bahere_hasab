import 'package:flutter/material.dart';

import '../app_preferences.dart';
import '../l10n.dart';
import '../theme_colors.dart';
import '../widgets/app_drawer.dart';

class AccessibilityScreen extends StatelessWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('ተደራሽነት', 'Accessibility'))),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: L10n.lang,
        builder: (context, lang, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _infoCard(
                context,
                icon: Icons.text_fields,
                title: L10n.t('የጽሁፍ መጠን', 'Adjustable text size'),
                body: L10n.t(
                  'ከትምህርት መጠኑን ትንሽ፣ መካከለኛ ወይም ትልቅ '
                      'ማድረግ ይችላሉ። ከስርዓቱ የጽሁፍ መጠን ጋርም '
                      'ይዛመዳል።',
                  'You can choose small, medium or large text from Settings. '
                      'The app also respects your system font size.',
                ),
              ),
              _infoCard(
                context,
                icon: Icons.contrast,
                title: L10n.t('ከፍተኛ ንጽጽር', 'High contrast'),
                body: L10n.t(
                  'ለአይነት ችግር ያለባቸው ተጠቃሚዎች ጠንካራ ቀለም '
                      'ንጽጽር ማብራት ይችላሉ።',
                  'Turn on stronger colour contrast for easier reading, '
                      'useful for low-vision users.',
                ),
              ),
              _infoCard(
                context,
                icon: Icons.record_voice_over,
                title: L10n.t('የስክሪን አንባቢ ድጋፍ', 'Screen-reader support'),
                body: L10n.t(
                  'ሁሉም ቁልፎችና ይዘቶች ለTalkBack (እና VoiceOver) '
                      'ግልጽ የሆነ መለያ (label) አላቸው። በድምጽ ማንበብ '
                      'ተጠቅመው በአመለካከት ወይም ብ ስብስብ ማሰስ ይችላሉ።',
                  'Every button and section has a clear label for TalkBack '
                      '(and VoiceOver). You can navigate by swiping with the '
                      'screen reader.',
                ),
              ),
              _infoCard(
                context,
                icon: Icons.palette,
                title: L10n.t('ግልጽ ቀለሞች', 'Readable colours'),
                body: L10n.t(
                  'በጽሑፍና በመደብ መካከል ጥሩ ንጽጽር ለማግኘት '
                      'ቀለሞችን በጥንቃቄ ተመርጠዋል።',
                  'Colours were chosen carefully for good contrast between '
                      'text and background.',
                ),
              ),
              _infoCard(
                context,
                icon: Icons.touch_app,
                title: L10n.t('ትላልቅ መንካቶች', 'Large touch targets'),
                body: L10n.t(
                  'ቁልፎችና ዝርዝሮች በቀላሉ ለመንካት ትልቅ ቦታ '
                      'አላቸው።',
                  'Buttons and list items have generous touch areas.',
                ),
              ),
              const SizedBox(height: 8),
              _section(
                context,
                L10n.t('ፈጣን ማስተካከያ', 'Quick adjustments'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.t('የጽሁፍ መጠን', 'Text size'),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 12),
                    ValueListenableBuilder(
                      valueListenable: AppPrefs.highContrast,
                      builder: (context, hc, _) {
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(L10n.t('ከፍተኛ ንጽጽር', 'High contrast')),
                          value: hc,
                          activeTrackColor: AppColors.of(context).primary,
                          onChanged: (v) => AppPrefs.highContrast.value = v,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    L10n.t(
                      'ነገር አልመመችዎት ከሆነ ለእርዳታ '
                          'ከኦርያሬስ ያግኙ።',
                      'If something is hard to use, reach out to Oryares '
                          'for help.',
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

  Widget _infoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.of(context).primary.withValues(
                alpha: 0.15,
              ),
              child: Icon(icon, color: AppColors.of(context).primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(fontSize: 13.5, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
