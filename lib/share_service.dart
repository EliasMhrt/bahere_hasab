import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'app_info.dart';
import 'l10n.dart';

/// Opens the native Android share sheet so the user can send the app to
/// another phone.
class ShareService {
  ShareService._();

  static const MethodChannel _channel = MethodChannel('bahere_hasab/share');

  static String get _message => L10n.t(
    'ባህረ ሃሳብ: የኢትዮጵያ ኦርቶዶክስ ተዋህዶ ቤተ ክርስትያን የቀን አቆጣጠርና የባህረ ሃሳብ ሂሳብ መተግበሪያ።',
    'Bahire Hasab: an offline Ethiopian Orthodox calendar (feasts, fasts and '
    'the Bahire Hasab method).',
  );

  /// Shares the installed APK through the system share sheet.
  ///
  /// File-transfer apps (Quick Share, Xender, …) and messaging apps both
  /// receive the APK installer.
  static Future<void> shareApp() async {
    final subject = L10n.t('ባህረ ሃሳብ', 'Bahire Hasab');
    try {
      final apkPath = await _channel.invokeMethod<String>('getApkPath');
      if (apkPath != null && apkPath.isNotEmpty) {
        final dir = await getTemporaryDirectory();
        final dest = File('${dir.path}/Bahire-Hasab-v${AppInfo.version}.apk');
        await File(apkPath).copy(dest.path);
        await SharePlus.instance.share(
          ShareParams(
            files: [
              XFile(
                dest.path,
                mimeType: 'application/vnd.android.package-archive',
              ),
            ],
            text: _message,
            subject: subject,
          ),
        );
        return;
      }
    } catch (_) {
      // Fall through to a link-only share.
    }
    await SharePlus.instance.share(
      ShareParams(text: _message, subject: subject),
    );
  }
}
