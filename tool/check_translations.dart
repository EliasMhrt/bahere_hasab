import 'dart:io';

import 'package:bahere_hasab/l10n/app_language.dart';
import 'package:bahere_hasab/l10n/dictionaries.dart';

void main() {
  final keys = File('tool/l10n_keys.txt')
      .readAsLinesSync()
      .map((l) => l.replaceAll(r'\n', '\n'))
      .where((l) => l.isNotEmpty)
      .toSet();

  for (final entry in kTranslations.entries) {
    final lang = entry.key;
    final map = entry.value;
    final invalid = map.keys.where((k) => !keys.contains(k)).toList();
    stdout.writeln(
      '${lang.code.padRight(4)} ${lang.englishLabel.padRight(10)} '
      '${map.length.toString().padLeft(4)} entries, '
      '${invalid.length} invalid keys',
    );
    for (final k in invalid.take(5)) {
      stdout.writeln('   INVALID: $k');
    }
  }
}
