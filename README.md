# ባህረ ሃሳብ · Bahere Hasab

የየኢትዮጵያ ኦርቶዶክስ ተዋሕዶ ቤተ ክርስቲያን የባህረ ሃሳብ ሂሳብ አፕ — የበዓላትን፣ የጾማትንና የቀኖችን አቆጣጠር ደረጃ በደረጃ ያስላል።

An offline Ethiopian Orthodox Tewahedo calendar app — calculates feasts, fasts, and dates step by step. Works completely offline; no account, ads, or data collection.

## Features

- Festivals & fasting calendar (ጾምና በዓላት)
- Step-by-step Bahire Hasab calculator (የባህረ ሃሳብ ሂሳብ)
- Date converter between Ethiopic and Gregorian (ቀን መለወጫ)
- Learn the Bahire Hasab method in brief (ትምህርት)
- Multilingual: Amharic & English plus Tigrinya, Ge'ez, Afaan Oromoo, Somali,
  Afar, Sidama, Wolaytta, Hadiyya, Gamo, Gurage (Sebat Bet), Silt'e and Harari.
  Amharic and English are the reference versions; the newer translations are
  drafts and fall back to Amharic (Ethiopic-script) or English (Latin-script)
  where a string is not yet translated
- Follows the system light/dark theme by default
- Share the app straight from the home screen or the side menu
- Optional fasting reminder — a persistent notification that names the
  current fasting season and rotates between the Ethiopian and Gregorian date
- Offline, no tracking; asks for notification permission only if you enable the
  reminder

## Install

Enable "Install unknown apps" on your device, open the APK for your phone from **Releases**, and follow the prompts.

- `app-arm64-v8a-release.apk` — most phones from ~2015 onwards (64-bit)
- `app-armeabi-v7a-release.apk` — older 32-bit phones
- Minimum Android version: Android 5.0 (API 21)
- Package name: `com.baherehasab.bahere_hasab`

Builds are produced per CPU architecture (`--split-per-abi`), so each APK is
about half the size of a single universal build and no PC/emulator (x86_64)
payload is shipped.

## Privacy

The app is fully offline. It collects, stores, and transmits nothing. Look-and-feel preferences and language are kept only in memory for the current session. If you switch on the fasting reminder, its on/off state is stored locally on your device (using Android SharedPreferences) so the reminder can continue after a restart; it is removed when you uninstall the app. Enabling the reminder also requests the notification permission, used solely to display the ongoing reminder.