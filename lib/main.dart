import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'app_preferences.dart';
import 'l10n.dart';
import 'notification_service.dart';
import 'screens/home_screen.dart';

void main() {
  FlutterForegroundTask.initCommunicationPort();
  runApp(const BahereHasabApp());
}

class BahereHasabApp extends StatefulWidget {
  const BahereHasabApp({super.key});

  @override
  State<BahereHasabApp> createState() => _BahereHasabAppState();
}

class _BahereHasabAppState extends State<BahereHasabApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    L10n.lang.addListener(_onPrefsChanged);
    AppPrefs.textScale.addListener(_onPrefsChanged);
    AppPrefs.themeMode.addListener(_onPrefsChanged);
    AppPrefs.highContrast.addListener(_onPrefsChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initReminder());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    L10n.lang.removeListener(_onPrefsChanged);
    AppPrefs.textScale.removeListener(_onPrefsChanged);
    AppPrefs.themeMode.removeListener(_onPrefsChanged);
    AppPrefs.highContrast.removeListener(_onPrefsChanged);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      NotificationService.markAppOpened();
    }
  }

  Future<void> _initReminder() async {
    NotificationService.init();
    await NotificationService.markAppOpened();
    await NotificationService.saveLanguage(L10n.lang.value);
    AppPrefs.reminder.value = await NotificationService.isEnabled();
    await NotificationService.resume();
  }

  void _onPrefsChanged() {
    NotificationService.saveLanguage(L10n.lang.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final contrast = AppPrefs.highContrast.value ? 1.0 : 0.0;

    final lightScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF8C1F28),
      brightness: Brightness.light,
      contrastLevel: contrast,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB0454F),
      brightness: Brightness.dark,
      contrastLevel: contrast,
    );

    return MaterialApp(
      title: 'ባህረ ሃሳብ',
      debugShowCheckedModeBanner: false,
      theme: _theme(lightScheme, const Color(0xFFFAF5EC)),
      darkTheme: _theme(darkScheme, const Color(0xFF171112)),
      themeMode: AppPrefs.themeFor(AppPrefs.themeMode.value),
      builder: (context, child) {
        final scale = AppPrefs.scaleFor(AppPrefs.textScale.value);
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        );
      },
      locale: L10n.lang.value.usesEthiopicScript
          ? const Locale('am')
          : const Locale('en'),
      home: HomeScreen(
        key: ValueKey(
          '${L10n.lang.value}-${AppPrefs.themeMode.value}-${AppPrefs.textScale.value}-${AppPrefs.highContrast.value}',
        ),
      ),
    );
  }

  ThemeData _theme(ColorScheme scheme, Color scaffoldBackground) {
    final isDark = scheme.brightness == Brightness.dark;
    final ripple = scheme.primary.withValues(alpha: isDark ? 0.35 : 0.15);
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackground,
      useMaterial3: true,
      fontFamily: 'NotoSansEthiopic',
      splashColor: ripple,
      highlightColor: scheme.primary.withValues(alpha: isDark ? 0.12 : 0.06),
      hoverColor: scheme.primary.withValues(alpha: isDark ? 0.10 : 0.05),
      focusColor: scheme.primary.withValues(alpha: isDark ? 0.14 : 0.08),
      splashFactory: defaultTargetPlatform == TargetPlatform.android
          ? InkSparkle.splashFactory
          : InkRipple.splashFactory,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(ripple),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF2A1F20) : scheme.primary,
        foregroundColor: isDark ? scheme.onSurface : scheme.onPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? const Color(0xFF241B1B) : Colors.white,
      ),
    );
  }
}
