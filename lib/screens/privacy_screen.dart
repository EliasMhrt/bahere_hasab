import 'package:flutter/material.dart';

import '../l10n.dart';
import '../widgets/app_drawer.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('የግላዊነት ፖሊሲ', 'Privacy Policy'))),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: L10n.lang,
        builder: (context, lang, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _s(
                context,
                L10n.t('አጠቃላይ እይታ', 'Overview'),
                L10n.t(
                  'ባህረ ሐሳብ ሙሉ በሙሉ ከመስመር ውጪ የሚሰራ '
                      'የማጣቀሻ መተግበሪያ ነው። መለያ አያስፈልገውም፣ '
                      'በይነመረብ አይጠቀምም፣ አማካሪ (analytics)፣ '
                      'ማስታወቂያ ወይም ክትትል የለም። ስለእርስዎ ምንም '
                      'የግል መረጃ አንሰበስብም፣ አንመዘግብም፣ አናስተላልፍም።',
                  'Bahire Hasab is a fully offline reference app. It does not '
                      'require an account, does not use the internet, and has '
                      'no analytics, advertising or tracking. We do not '
                      'collect, store, or transmit any personal information '
                      'about you.',
                ),
              ),
              _s(
                context,
                L10n.t('የማንሰበስብቸው መረጃዎች', 'Data we do not collect'),
                L10n.t(
                  '• ስም፣ ኢሜይል፣ ስልክ ወይም አድራሻ።\n'
                      '• የመሣሪያ ቁጥር (device ID)፣ የአይፒ አድራሻ ወይም '
                      'የአካባቢ መረጃ።\n'
                      '• መተግበሪያውን እንዴት እንደተጠቀሙበት የሚጠቁም '
                      'ታሪክ።\n'
                      '• ኩኪዎች (cookies) ወይም የማስታወቂያ መለያዎች።',
                  '• Your name, email, phone number or address.\n'
                      '• Device identifiers, IP addresses or location data.\n'
                      '• A usage history of how you use the app.\n'
                      '• Cookies or advertising identifiers.',
                ),
              ),
              _s(
                context,
                L10n.t(
                  'በመሣሪያዎ የሚቆዩ ምርጫዎች',
                  'Preferences stored on your device',
                ),
                L10n.t(
                  'ቋንቋ፣ የጽሁፍ መጠንና መልክ የመሳሰሉ ምርጫዎች '
                      'በመሣሪያዎ ብቻ ውስጥ ይቆያሉ። ወደ ውጭ አይወጡም። '
                      'መተግበሪያውን ሲያስወግዱ (uninstall) ይጠፋሉ።',
                  'Preferences such as language, text size and appearance stay '
                      'only on your device and are never transmitted. They are '
                      'cleared when the app is uninstalled.',
                ),
              ),
              _s(
                context,
                L10n.t('ፈቃዶች (Permissions)', 'Permissions'),
                L10n.t(
                  'መተግበሪያው ምንም አይነት የአካል (sensitive) ፈቃድ '
                      'አይጠይቅም፣ የበይነመረብ ፈቃድም አይያዝም።',
                  'The app requests no sensitive permission and holds no '
                      'internet permission.',
                ),
              ),
              _s(
                context,
                L10n.t('የሶስተኛ ወገን ሶፍትዌር', 'Third-party software'),
                L10n.t(
                  'መተግበሪያው እንደ Flutter ያሉ ክፍት ምንጭ (open-source) '
                      'መሳሪያዎችንና ቅርጸ-ቁመቶችን ይጠቀማል፤ ሁሉም '
                      'በመሣሪያዎ ውስጥ ብቻ ይሰራሉ። ዝርዝሩን በ'
                      '›የሶስተኛ ወገን መረጃ‹ ክፍል ይመልከቱ።',
                  'The app relies on open-source components such as Flutter and '
                      'fonts, which run entirely on your device. Details are in '
                      'the "Third-Party Data" section.',
                ),
              ),
              _s(
                context,
                L10n.t('ለልጆች', 'Children'),
                L10n.t(
                  'መተግበሪያው ለሁሉም ዕድሜ ተስማሚ ነው፤ ስለልጆች '
                      'ምንም መረጃ አንሰበስብም።',
                  'The app is suitable for all ages, and we collect no data '
                      'about children.',
                ),
              ),
              _s(
                context,
                L10n.t('የፖሊሲው ለውጦች', 'Changes to this policy'),
                L10n.t(
                  'የዚህ ፖሊሲ ዝማኔዎች በመተግበሪያው ቅጽ ይታተማሉ።',
                  'Any updates to this policy will be published inside the '
                      'app.',
                ),
              ),
              _s(
                context,
                L10n.t('ለማነጋገር', 'Contact'),
                L10n.t(
                  'ለጥያቄዎች ወይም ሐሳቦች፡ የገንቢውን (ኦርያሬስ) '
                      'አድራሻ ያነጋግሩ።\nኢሜይል፡ oryares.01@gmail.com',
                  'For questions or feedback, please contact the developer '
                      '(Oryares):\nEmail: oryares.01@gmail.com',
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
    return Card(
      color: const Color(0xFFFFF3D6),
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
            color: Colors.brown.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}
