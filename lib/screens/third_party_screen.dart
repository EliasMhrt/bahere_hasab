import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme_colors.dart';
import '../widgets/app_drawer.dart';

class ThirdPartyScreen extends StatelessWidget {
  const ThirdPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('የሶስተኛ ወገን መረጃ', 'Third-Party Data'))),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: L10n.lang,
        builder: (context, lang, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: AppColors.of(context).noticeCard,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    L10n.t(
                      'ባህረ ሐሳብ ሙሉ በሙሉ ከመስመር ውጪ ነው። ከታች '
                          'የተዘረዘሩት ክፍት-ምንጭ ክፍሎች በመሣሪያዎ ውስጥ '
                          'ብቻ ይሰራሉ። መተግበሪያው ምንም አባላት '
                          'መስመር ግንኙነት የለውም፤ ወደ ሶስተኛ ወገን '
                          'ምንም መረጃ አናስተላልፍም።',
                      'Bahire Hasab is fully offline. The open-source '
                          'components listed below run entirely on your '
                          'device. The app makes no network connections and '
                          'shares no data with any third party.',
                    ),
                    style: const TextStyle(fontSize: 13.5, height: 1.5),
                  ),
                ),
              ),
              _row(
                context,
                'Flutter',
                'BSD 3-Clause',
                L10n.t('የአገሪንግ ስርዓት', 'UI framework'),
              ),
              _row(
                context,
                'Dart SDK',
                'BSD 3-Clause',
                L10n.t('የፕሮግራም ቋንቋ', 'Programming language'),
              ),
              _row(
                context,
                'Material Icons',
                'Apache 2.0',
                L10n.t('አዶዎች', 'Icons'),
              ),
              _row(
                context,
                'Noto Sans Ethiopic',
                'SIL OFL 1.1',
                L10n.t('የኢትዮጵያ ቅርጸ-ቁመት', 'Ethiopic typeface'),
              ),
              _row(
                context,
                'cupertino_icons',
                'MIT',
                L10n.t('የCupertino አዶዎች', 'Cupertino icons'),
              ),
              _row(
                context,
                'flutter_test',
                'BSD 3-Clause',
                L10n.t('ፈተና (dev)', 'Testing (dev-only)'),
              ),
              _row(
                context,
                'flutter_lints',
                'BSD 3-Clause',
                L10n.t('ትንተና (dev)', 'Linting (dev-only)'),
              ),
              _row(
                context,
                'flutter_launcher_icons',
                'MIT',
                L10n.t('አዶ ማመንጫ (dev)', 'Icon generator (dev-only)'),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    L10n.t(
                      'ፍቃዶቹ ሙሉ ጽሑፍ በየፕሮጀክቱ ድረ-ገጾች ይገኛል። '
                          'በጊዜው በpub.yaml ፋይል ውስጥ ያሉት ስሪቶች '
                          'መሆናቸውን ልብ ይበሉ።',
                      'Full license texts are available on each project\'s '
                          'website. Versions used are those listed in the '
                          'pubspec.yaml file.',
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

  Widget _row(BuildContext context, String name, String license, String use) {
    final c = AppColors.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: c.primary.withValues(alpha: 0.15),
          child: Icon(Icons.extension, color: c.primary, size: 20),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('$license · $use'),
        trailing: Text(
          license,
          style: TextStyle(
            fontSize: 11,
            color: c.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
