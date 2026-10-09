/// The languages the app can display. Amharic and English are the originals;
/// Tigrinya, Afar and Oromo are community translations. Every language is
/// fully translated, so there is no fallback at runtime.
enum AppLanguage {
  amharic('am', 'አማርኛ', 'Amharic', true),
  english('en', 'English', 'English', false),
  tigrinya('ti', 'ትግርኛ', 'Tigrinya', true),
  afar('aa', 'Qafar', 'Afar', false),
  oromo('om', 'Afaan Oromoo', 'Oromo', false);

  const AppLanguage(
    this.code,
    this.nativeLabel,
    this.englishLabel,
    this.usesEthiopicScript,
  );

  final String code;
  final String nativeLabel;
  final String englishLabel;
  final bool usesEthiopicScript;

  /// Label shown in language pickers: "Native · English".
  String get displayLabel =>
      nativeLabel == englishLabel ? nativeLabel : '$nativeLabel · $englishLabel';
}
