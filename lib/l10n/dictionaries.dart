import 'app_language.dart';
import 'tr_aa.dart';
import 'tr_gez.dart';
import 'tr_gmv.dart';
import 'tr_gru.dart';
import 'tr_har.dart';
import 'tr_hdy.dart';
import 'tr_om.dart';
import 'tr_sid.dart';
import 'tr_so.dart';
import 'tr_stv.dart';
import 'tr_ti.dart';
import 'tr_wal.dart';

/// Per-language lookup tables keyed by the English source string.
///
/// Amharic and English are handled directly by [L10n]; every other language
/// uses its map here and falls back when a key is missing.
const Map<AppLanguage, Map<String, String>> kTranslations = {
  AppLanguage.tigrinya: kTi,
  AppLanguage.geez: kGez,
  AppLanguage.oromo: kOm,
  AppLanguage.somali: kSo,
  AppLanguage.afar: kAa,
  AppLanguage.sidama: kSid,
  AppLanguage.wolaytta: kWal,
  AppLanguage.hadiyya: kHdy,
  AppLanguage.gamo: kGmv,
  AppLanguage.gurage: kGru,
  AppLanguage.silte: kStv,
  AppLanguage.harari: kHar,
};
