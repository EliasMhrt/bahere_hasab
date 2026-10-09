/// The languages the app can display. Amharic and English are the originals;
/// the rest are community translations that fall back to Amharic (Ethiopic
/// script languages) or English (Latin script languages) when a string has not
/// been translated yet.
enum AppLanguage {
  amharic('am', 'አማርኛ', 'Amharic', true),
  english('en', 'English', 'English', false),
  tigrinya('ti', 'ትግርኛ', 'Tigrinya', true),
  geez('gez', 'ግዕዝ', "Ge'ez", true),
  oromo('om', 'Afaan Oromoo', 'Oromo', false),
  somali('so', 'Soomaali', 'Somali', false),
  afar('aa', 'Qafar', 'Afar', false),
  sidama('sid', 'Sidaamu Afoo', 'Sidama', false),
  wolaytta('wal', 'Wolaytta', 'Wolaytta', false),
  hadiyya('hdy', 'Hadiyyisa', 'Hadiyya', false),
  gamo('gmv', 'Gamo', 'Gamo', false),
  gurage('gru', 'ጉራጌ', 'Gurage', true),
  silte('stv', 'ስልጥኛ', "Silt'e", true),
  harari('har', 'ሐረሪ', 'Harari', true);

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
