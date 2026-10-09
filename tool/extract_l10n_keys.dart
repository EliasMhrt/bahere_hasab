import 'dart:convert';
import 'dart:io';

/// Extracts the English source strings used by the app's L10n.t(am, en) calls
/// plus the calendar/festival data names that are rendered through L10n.
///
/// Prints one string per line (newlines escaped as \n). Skips interpolated
/// strings (those containing $) because they are not constant keys.
void main() {
  final dir = Directory('lib');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && !f.path.contains('l10n'))
      .toList();

  final ui = <String>{};
  for (final f in files) {
    ui.addAll(_extractUiStrings(f.readAsStringSync()));
  }

  final data = <String>{
    // Festivals.fixedFeasts englishName
    'Enkutatash (Ethiopian New Year)',
    'Meskel (Finding of the True Cross)',
    'Feast of St. Mary of Zion',
    'Genna (Ethiopian Christmas)',
    'Timkat (Epiphany)',
    'Annunciation Show (Debre Zeit)',
    'Feast of the Holy Apostles',
    'Debre Tabor (Transfiguration)',
    'Filseta (Dormition of St. Mary)',
    // monthlyCommemorations englishName
    'St. Michael',
    'St. Gabriel',
    'St. Mary',
    'St. George',
    // moveable feasts / fasts (CalendarEvent.subtitle)
    'Fast of Nineveh',
    'Great Lent (Hudade)',
    'Mid-Lent Sunday',
    'Palm Sunday',
    'Good Friday (Crucifixion)',
    'Easter (Resurrection)',
    "Rikbe Kahanat (Priests' Assembly)",
    'Ascension',
    'Peraqlitos (Pentecost)',
    'Fast of the Apostles',
    'Fast of the Prophets (Advent)',
    'Fast of Gahad (Christmas Eve)',
    'Fast of the Assumption (Filseta)',
    // fasting seasons englishName
    'Fast of Tsige (Zemene Tsige)',
    'Fast of Gahad',
    // evangelists
    'Matthew',
    'Mark',
    'Luke',
    'John',
    // weekday/month/gregorian arrays
    'Meskerem',
    'Tikimt',
    'Hidar',
    'Tahsas',
    'Tir',
    'Yekatit',
    'Megabit',
    'Miyazya',
    'Ginbot',
    'Sene',
    'Hamle',
    'Nehase',
    'Pagume',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'E.C.',
    'Amete Mihret',
    // notification_service.dart L10n.forLanguage calls
    'Weekly fast',
    'No fasting',
    // full Gregorian month names
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  };

  final all = <String>{...ui, ...data}.toList()..sort();
  final out = File('tool/l10n_keys.txt');
  out.writeAsStringSync(
    all.map((s) => s.replaceAll('\\', r'\\').replaceAll('\n', r'\n')).join('\n'),
    encoding: utf8,
  );
  print('ui=${ui.length} total=${all.length} -> ${out.path}');
}

Set<String> _extractUiStrings(String src) {
  final out = <String>{};
  for (final needle in const ['L10n.t(', 'L10n.tp(']) {
    var idx = 0;
    while (true) {
      idx = src.indexOf(needle, idx);
      if (idx == -1) break;
      final open = idx + needle.length - 1; // index of '('
      final args = _parseArgs(src, open);
      if (args.length >= 2 && args[1] != null) {
        out.add(args[1]!);
      }
      idx = open + 1;
    }
  }
  return out;
}

/// Returns the resolved constant string values of the call's arguments, with
/// `null` for arguments that are not constant string literals.
List<String?> _parseArgs(String s, int open) {
  final args = <String?>[];
  var i = open + 1;
  var depth = 1;
  final parts = <String>[];
  var isString = true;
  var sawAny = false;

  void flush() {
    args.add(sawAny && isString ? parts.join() : null);
    parts.clear();
    isString = true;
    sawAny = false;
  }

  while (i < s.length) {
    final c = s[i];
    if (c == "'" || c == '"') {
      final res = _readString(s, i);
      if (res == null) {
        isString = false;
        // skip to end of the malformed literal
        i = _skipString(s, i);
      } else {
        parts.add(res.value);
        i = res.end;
      }
      sawAny = true;
      continue;
    }
    if (c == ',' && depth == 1) {
      flush();
      i++;
      continue;
    }
    if (c == '(' || c == '[' || c == '{') {
      depth++;
    } else if (c == ')' || c == ']' || c == '}') {
      depth--;
      if (depth == 0) {
        flush();
        break;
      }
    } else if (c == r'$' && i + 1 < s.length) {
      final n = s[i + 1];
      if (n == '{' || RegExp(r'[A-Za-z_]').hasMatch(n)) {
        if (sawAny || parts.isNotEmpty) {
          isString = false;
        } else {
          isString = false;
        }
      }
    } else if (c != ' ' && c != '\t' && c != '\n' && c != '\r') {
      // a non-string token (identifier, number, etc.)
      if (parts.isNotEmpty || sawAny) isString = false;
      isString = false;
      sawAny = true;
    }
    i++;
  }
  return args;
}

class _Str {
  _Str(this.value, this.end);
  final String value;
  final int end;
}

_Str? _readString(String s, int i) {
  final quote = s[i];
  final triple = i + 2 < s.length && s[i + 1] == quote && s[i + 2] == quote;
  final sb = StringBuffer();
  var j = triple ? i + 3 : i + 1;
  while (j < s.length) {
    if (!triple && s[j] == '\n') return null;
    if (s[j] == r'\') {
      if (j + 1 >= s.length) return null;
      final n = s[j + 1];
      switch (n) {
        case 'n':
          sb.write('\n');
        case 't':
          sb.write('\t');
        case 'r':
          sb.write('\r');
        case r'\':
          sb.write(r'\');
        case "'":
          sb.write("'");
        case '"':
          sb.write('"');
        case r'$':
          sb.write(r'$');
          j = j; // keep
        default:
          sb.write(n);
      }
      j += 2;
      continue;
    }
    if (s[j] == r'$') {
      final n = j + 1 < s.length ? s[j + 1] : '';
      if (n == '{' || RegExp(r'[A-Za-z_]').hasMatch(n)) {
        return null; // interpolated
      }
    }
    if (triple) {
      if (s[j] == quote && j + 2 < s.length && s[j + 1] == quote && s[j + 2] == quote) {
        return _Str(sb.toString(), j + 3);
      }
    } else if (s[j] == quote) {
      return _Str(sb.toString(), j + 1);
    }
    sb.write(s[j]);
    j++;
  }
  return triple ? _Str(sb.toString(), j) : null;
}

int _skipString(String s, int i) {
  final quote = s[i];
  var j = i + 1;
  while (j < s.length) {
    if (s[j] == r'\') {
      j += 2;
      continue;
    }
    if (s[j] == quote) return j + 1;
    j++;
  }
  return j;
}
