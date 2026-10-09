import 'package:flutter/material.dart';

/// Theme-aware colours shared across the app.
///
/// Screens previously used hard-coded colours (deep red, cream cards, black
/// text), which stayed dark-on-dark and made several screens unreadable once
/// dark mode was enabled. These getters return the correct tone for the
/// current brightness so the whole app stays legible in light and dark mode.
class AppColors {
  const AppColors._(this._scheme);

  factory AppColors.of(BuildContext context) =>
      AppColors._(Theme.of(context).colorScheme);

  final ColorScheme _scheme;

  bool get _isDark => _scheme.brightness == Brightness.dark;

  /// Brand / liturgical accent. Follows the generated colour scheme so it also
  /// respects the high-contrast setting.
  Color get primary => _scheme.primary;

  /// Content rendered on top of [primary].
  Color get onPrimary => _scheme.onPrimary;

  /// Default body text.
  Color get text => _scheme.onSurface;

  /// Secondary text (labels, captions, footnotes).
  Color get muted => _scheme.onSurface.withValues(alpha: _isDark ? 0.78 : 0.62);

  /// Very faint text (developer credit, copyright).
  Color get faint => _scheme.onSurface.withValues(alpha: _isDark ? 0.55 : 0.45);

  /// Gregorian day number shown under the Ethiopian day in the calendar.
  Color get gregDay => _scheme.onSurfaceVariant;

  // Liturgical status colours.
  Color get fasting => _scheme.primary;
  Color get weeklyFast =>
      _isDark ? const Color(0xFF9DB8EE) : const Color(0xFF3E5C9A);
  Color get noFast =>
      _isDark ? const Color(0xFF86D3A6) : const Color(0xFF1E7A46);
  Color get majorFeast =>
      _isDark ? const Color(0xFFE9CB6B) : const Color(0xFFB8860B);
  Color get feast =>
      _isDark ? const Color(0xFFE3B573) : const Color(0xFFD9A441);
  Color get weekdayLabel =>
      _isDark ? const Color(0xFFD8BE8E) : const Color(0xFF6E4B12);

  /// Tinted "note" card background (used by privacy, terms, third-party and
  /// the education notes). Dark mode uses a warm charcoal instead of cream.
  Color get noticeCard =>
      _isDark ? const Color(0xFF2A2118) : const Color(0xFFFFF3D6);
  Color get noticeText =>
      _isDark ? const Color(0xFFE4CBA6) : const Color(0xFF5D4037);

  /// Default (empty) border of a calendar day cell.
  Color get dayBorder =>
      _isDark ? const Color(0xFF4A342E) : const Color(0xFFFFE9C9);
}
