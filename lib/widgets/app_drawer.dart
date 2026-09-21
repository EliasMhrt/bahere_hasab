import 'package:flutter/material.dart';

import '../l10n.dart';
import '../screens/accessibility_screen.dart';
import '../screens/calculator_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/converter_screen.dart';
import '../screens/education_screen.dart';
import '../screens/privacy_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/terms_screen.dart';
import '../screens/third_party_screen.dart';

/// Sidebar (navigation drawer) shared by every screen in the app.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF8C1F28),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
              child: const Row(
                children: [
                  Icon(
                    Icons.calendar_view_month,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ባህረ ሃሳብ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Bahire Hasab',
                          style: TextStyle(
                            color: Color(0xFFE8D5C4),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: L10n.lang,
                builder: (context, lang, _) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _GroupLabel(L10n.t('ዋና', 'Main')),
                      _Item(
                        icon: Icons.home,
                        label: L10n.t('መነሻ', 'Home'),
                        onTap: () => _home(context),
                      ),
                      _Item(
                        icon: Icons.calendar_month,
                        label: L10n.t('ጾምና በዓላት', 'Calendar'),
                        onTap: () => _go(context, const CalendarScreen()),
                      ),
                      _Item(
                        icon: Icons.calculate,
                        label: L10n.t('የባህረ ሃሳብ ሂሳብ', 'Calculator'),
                        onTap: () => _go(context, const CalculatorScreen()),
                      ),
                      _Item(
                        icon: Icons.swap_horiz,
                        label: L10n.t('ቀን መለወጫ', 'Date Converter'),
                        onTap: () => _go(context, const ConverterScreen()),
                      ),
                      _Item(
                        icon: Icons.menu_book,
                        label: L10n.t('ትምህርት', 'Learn'),
                        onTap: () => _go(context, const EducationScreen()),
                      ),
                      const Divider(height: 24),
                      _GroupLabel(L10n.t('ማስተካከያ', 'Personalization')),
                      _Item(
                        icon: Icons.settings,
                        label: L10n.t('ማስተካከያ', 'Settings'),
                        onTap: () => _go(context, const SettingsScreen()),
                      ),
                      _Item(
                        icon: Icons.accessibility_new,
                        label: L10n.t('ተደራሽነት', 'Accessibility'),
                        onTap: () => _go(context, const AccessibilityScreen()),
                      ),
                      const Divider(height: 24),
                      _GroupLabel(L10n.t('ሕጋዊ መረጃ', 'Legal')),
                      _Item(
                        icon: Icons.privacy_tip,
                        label: L10n.t('የግላዊነት ፖሊሲ', 'Privacy Policy'),
                        onTap: () => _go(context, const PrivacyScreen()),
                      ),
                      _Item(
                        icon: Icons.gavel,
                        label: L10n.t('አገልግሎት ውሎች', 'Terms & Conditions'),
                        onTap: () => _go(context, const TermsScreen()),
                      ),
                      _Item(
                        icon: Icons.extension,
                        label: L10n.t('የሶስተኛ ወገን መረጃ', 'Third-Party Data'),
                        onTap: () => _go(context, const ThirdPartyScreen()),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                L10n.t(
                  'በ ኦርያሬስ የተሰራ · ስሪት 1.0.0',
                  'Developed by Oryares · v1.0.0',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withValues(alpha: 0.45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _home(BuildContext context) {
    final nav = Navigator.of(context);
    nav.pop(); // close the drawer
    nav.popUntil((route) => route.isFirst);
  }

  void _go(BuildContext context, Widget screen) {
    final nav = Navigator.of(context);
    nav.pop(); // close the drawer
    nav.push(MaterialPageRoute<void>(builder: (_) => screen));
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: const Color(0xFF8C1F28).withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8C1F28)),
      title: Text(label),
      dense: true,
      onTap: onTap,
    );
  }
}
