import 'package:flutter/material.dart';

/// User-customizable preferences for the app. The look-and-feel values are kept
/// in memory only; the calendar reminder switch is persisted locally on the
/// device so the reminder can survive restarts.
class AppPrefs {
  AppPrefs._();

  static final ValueNotifier<AppTextScale> textScale = ValueNotifier(
    AppTextScale.medium,
  );
  static final ValueNotifier<AppThemeMode> themeMode = ValueNotifier(
    AppThemeMode.light,
  );
  static final ValueNotifier<bool> highContrast = ValueNotifier(false);
  static final ValueNotifier<bool> reminder = ValueNotifier(false);

  static double scaleFor(AppTextScale s) => switch (s) {
    AppTextScale.small => 0.9,
    AppTextScale.medium => 1.0,
    AppTextScale.large => 1.2,
  };

  static ThemeMode themeFor(AppThemeMode m) => switch (m) {
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };
}

enum AppTextScale {
  small('small'),
  medium('medium'),
  large('large');

  const AppTextScale(this.label);

  final String label;
}

enum AppThemeMode {
  light('light'),
  dark('dark'),
  system('system');

  const AppThemeMode(this.label);

  final String label;
}
