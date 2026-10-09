import 'package:flutter/material.dart';

import '../l10n.dart';
import '../theme_colors.dart';
import '../widgets/app_drawer.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('አገልግሎት ውሎች', 'Terms & Conditions'))),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: L10n.lang,
        builder: (context, lang, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _s(
                context,
                L10n.t('መቀበል', 'Acceptance'),
                L10n.t(
                  'መተግበሪያውን በመጠቀም በነዚህ ውሎች ተስማምተዋል። '
                      'የማይስማሙ ከሆነ ተጠቅመው ያቁሙ።',
                  'By using the app you agree to these terms. If you do not '
                      'agree, please stop using the app.',
                ),
              ),
              _s(
                context,
                L10n.t('ፍቃድ ለመጠቀም', 'License to use'),
                L10n.t(
                  'ለግልና መረጃ-ዓላማ ብቻ ነጻ መጠቀም ይቻላል። '
                      'ያለፈቃድ መልሶ ማሰራጨት፣ መሸጥ ወይም ማሻሻል '
                      'አይፈቀድም።',
                  'You may use the app freely for personal, informational '
                      'purposes only. Redistribution, resale or modification '
                      'without permission is not allowed.',
                ),
              ),
              _s(
                context,
                L10n.t('ውሳኔዎችን ማረጋገጥ', 'Verify the dates'),
                L10n.t(
                  'ቀኖቹ የሚሰላው በባህረ ሐሳብ ባህላዊ ሒሳብ ነው። '
                      'ለሃይማኖታዊ ጾምና በዓላት ወቅቱን በታች '
                      'ቤተክርስቲያንዎ ወይም በቀሳውስ ያረጋግጡ።',
                  'Dates are computed using the traditional Bahire Hasab '
                      'reckoning. Always confirm religious fasts and feasts '
                      'with your church or clergy.',
                ),
              ),
              _s(
                context,
                L10n.t('ዋስትና እና ኃላፊነት', 'No warranty & liability'),
                L10n.t(
                  'መተግበሪያው እንዳለ (as-is) ይቀርባል። በህግ '
                      'በሚፈቅደው መጠን ለማንኛውም ጉዳት ኃላፊነት '
                      'አንወስድም።',
                  'The app is provided "as is". To the extent permitted by '
                      'law, we accept no liability for any damages.',
                ),
              ),
              _s(
                context,
                L10n.t('የአእምሮ ሀብት', 'Intellectual property'),
                L10n.t(
                  'ኮድና ንድፍ © ኦርያሬስ። የባህረ ሐሳብ ሒሳብ የቤተክርስቲያን '
                      'ባህላዊ ቅርስ ነው። ቅርጸ-ቁመቶቹ (fonts) በክፍት '
                      'ፍቃዶች የቀረቡ ናቸው።',
                  'App code and design are © Oryares. The Bahire Hasab '
                      'reckoning is traditional church heritage. Fonts are '
                      'provided under open licenses.',
                ),
              ),
              _s(
                context,
                L10n.t('ለውጦች', 'Changes'),
                L10n.t(
                  'እነዚህ ውሎች ሊዘመኑ ይችላሉ፤ ዝማኔዎች በመተግበሪያው '
                      'ይታተማሉ።',
                  'These terms may be updated; changes will be published in '
                      'the app.',
                ),
              ),
              _s(
                context,
                L10n.t('ለማነጋገር', 'Contact'),
                L10n.t(
                  'ጥያቄዎች ካሉ የገንቢውን (ኦርያሬስ) አድራሻ '
                      'ያነጋግሩ።\nኢሜይል፡ oryares.01@gmail.com',
                  'For questions, contact the developer (Oryares):\n'
                      'Email: oryares.01@gmail.com',
                ),
              ),
              _notice(context),
            ],
          );
        },
      ),
    );
  }

  Widget _s(BuildContext context, String title, String body) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Text(body, style: const TextStyle(fontSize: 13.5, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _notice(BuildContext context) {
    final c = AppColors.of(context);
    return Card(
      color: c.noticeCard,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          L10n.t(
            'ማስታወሻ፡ ይህ መረጃ በቅንነት የቀረበ ሲሆን የሕግ ምክር '
                'አይደለም።',
            'Note: this information is provided in good faith and is not '
                'legal advice.',
          ),
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: c.noticeText,
          ),
        ),
      ),
    );
  }
}
