import 'app_language.dart';
import 'tr_aa.dart';
import 'tr_om.dart';
import 'tr_ti.dart';

/// Per-language lookup tables keyed by the English source string.
///
/// Amharic and English are handled directly by [L10n]; every other language
/// uses its map here.
const Map<AppLanguage, Map<String, String>> kTranslations = {
  AppLanguage.tigrinya: kTi,
  AppLanguage.afar: kAa,
  AppLanguage.oromo: kOm,
};
