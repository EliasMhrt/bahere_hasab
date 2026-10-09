import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'l10n.dart';
import 'src/calendar_math.dart';
import 'src/festivals.dart';

/// Storage keys for the plugin's private local store.
const String _kEnabledKey = 'reminder_enabled';
const String _kLastOpenedKey = 'reminder_last_opened';
const String _kLanguageKey = 'reminder_language';

/// The reminder turns itself off if the app has not been opened for this long.
const Duration reminderInactivityTimeout = Duration(days: 7);

const int _kServiceId = 248;
const int _kRotationMillis = 5000;

/// Top-level entry point used by the foreground service. Must stay a top-level
/// function annotated with `@pragma('vm:entry-point')`.
@pragma('vm:entry-point')
void reminderStartCallback() {
  FlutterForegroundTask.setTaskHandler(ReminderTaskHandler());
}

/// Runs inside the foreground service isolate and keeps the ongoing
/// notification up to date, rotating between the Ethiopian and Gregorian date.
class ReminderTaskHandler extends TaskHandler {
  bool _showGregorian = false;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _showGregorian = false;
    await _refresh();
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    _showGregorian = !_showGregorian;
    unawaited(_refresh());
  }

  Future<void> _refresh() async {
    if (await NotificationService.hasExpired()) {
      await FlutterForegroundTask.saveData(key: _kEnabledKey, value: false);
      await FlutterForegroundTask.stopService();
      return;
    }

    final language = await NotificationService.readLanguage();
    final content = NotificationService.buildContent(language, _showGregorian);
    await FlutterForegroundTask.updateService(
      notificationTitle: content.title,
      notificationText: content.text,
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
}

/// Controls the persistent "current fasting season" notification.
class NotificationService {
  NotificationService._();

  static bool _initialized = false;

  /// Configures the foreground service. Safe to call more than once.
  static void init() {
    if (_initialized) return;
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'bahire_hasab_reminder',
        channelName: 'Fasting reminder',
        channelDescription:
            'Shows the current Ethiopian Orthodox fasting season and date.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(_kRotationMillis),
        autoRunOnBoot: true,
        allowWakeLock: false,
        allowWifiLock: false,
        stopWithTask: false,
      ),
    );
    _initialized = true;
  }

  /// Builds the rotating notification content for [language].
  ///
  /// When [gregorian] is true the text shows the Gregorian date, otherwise the
  /// Ethiopian date with a shortened month name.
  static ({String title, String text}) buildContent(
    AppLanguage language,
    bool gregorian,
  ) {
    final amharic = language == AppLanguage.amharic;
    final now = DateTime.now();
    final jdn = CalendarMath.jdnFromGregorian(now.year, now.month, now.day);
    final season = Festivals.fastingSeasonOnJdn(jdn);
    final status = Festivals.fastStatusOnJdn(jdn);

    final String seasonLabel;
    if (season != null) {
      seasonLabel = L10n.seasonNameFor(language, season);
    } else if (status == FastStatus.weekly) {
      seasonLabel = amharic ? 'ሳምንታዊ ጾም' : 'Weekly fast';
    } else {
      seasonLabel = amharic ? 'ጾም የለም' : 'No fasting';
    }

    final String dateLabel;
    if (gregorian) {
      dateLabel =
          '${L10n.gregorianMonthShortFor(language, now.month)} '
          '${now.day}, ${now.year}';
    } else {
      final et = CalendarMath.ethiopicFromJdn(jdn);
      dateLabel =
          '${L10n.shortMonthNameFor(language, et.month)} '
          '${et.day}, ${et.year} ${amharic ? 'ዓ.ም.' : 'E.C.'}';
    }

    return (
      title: '${amharic ? 'ባህረ ሃሳብ' : 'Bahire Hasab'} · $seasonLabel',
      text: dateLabel,
    );
  }

  /// Whether the user wants the reminder on.
  static Future<bool> isEnabled() async {
    final value = await FlutterForegroundTask.getData<bool>(key: _kEnabledKey);
    return value ?? false;
  }

  /// Records that the app was opened so the reminder does not expire.
  static Future<void> markAppOpened() async {
    await FlutterForegroundTask.saveData(
      key: _kLastOpenedKey,
      value: DateTime.now().millisecondsSinceEpoch,
    );
  }

  static Future<void> saveLanguage(AppLanguage language) async {
    await FlutterForegroundTask.saveData(
      key: _kLanguageKey,
      value: language == AppLanguage.amharic ? 0 : 1,
    );
  }

  static Future<AppLanguage> readLanguage() async {
    final value = await FlutterForegroundTask.getData<int>(key: _kLanguageKey);
    return value == 1 ? AppLanguage.english : AppLanguage.amharic;
  }

  /// True when the app has not been opened within [reminderInactivityTimeout].
  static Future<bool> hasExpired() async {
    final last = await FlutterForegroundTask.getData<int>(key: _kLastOpenedKey);
    if (last == null) return false;
    final elapsed = DateTime.now().millisecondsSinceEpoch - last;
    return elapsed > reminderInactivityTimeout.inMilliseconds;
  }

  /// Turns the reminder on, requesting notification permission if needed.
  ///
  /// Returns false when the permission was denied, so the caller can revert the
  /// switch.
  static Future<bool> enable() async {
    init();
    final permission = await FlutterForegroundTask.checkNotificationPermission();
    if (permission != NotificationPermission.granted) {
      final result = await FlutterForegroundTask.requestNotificationPermission();
      if (result != NotificationPermission.granted) {
        return false;
      }
    }
    await FlutterForegroundTask.saveData(key: _kEnabledKey, value: true);
    await _start();
    return true;
  }

  /// Restarts the reminder on app launch without prompting for permission.
  static Future<void> resume() async {
    init();
    if (await isEnabled()) {
      await _start();
    }
  }

  /// Turns the reminder off.
  static Future<void> disable() async {
    await FlutterForegroundTask.saveData(key: _kEnabledKey, value: false);
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }

  static Future<void> _start() async {
    final content = buildContent(await readLanguage(), false);
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: _kServiceId,
        notificationTitle: content.title,
        notificationText: content.text,
        callback: reminderStartCallback,
      );
    }
  }
}
