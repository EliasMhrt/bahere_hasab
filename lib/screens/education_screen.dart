import 'package:flutter/material.dart';

import '../l10n.dart';
import '../widgets/app_drawer.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  static const _sections = [
    (
      'ባሕረ ሐሳብ ምንድን ነው?',
      'What is Bahire Hasab?',
      'ባሕረ ሐሳብ ማለት ቍጥር ያለው ዘመን ማለት ሲሆን፣ ሐሳበ ባሕር ቢል ግን የዘመን ቍጥር ማለት ነው። '
          'ባሕርን ዘመን ብሎ የተረጐመው ሱቱኤል ዕዝራ ነው፤ ዓለም በሚዛን ተመዝኗል፣ '
          'ባሕርንም በመስፈርት ስፍሮታል በማለት አስረድቷል። ሐሳብን ቍጥር ብሎ '
          'የተረጐመው ደግሞ ነቢዩ ዳዊት ነው።',
      'Bahire Hasab translates directly to a "numbered era", while the inverse '
          'phrase Hasabe Bahir means "the counting of time". Sutuel Ezra '
          'interpreted "Bahir" (Sea) as Time or Era — the world is weighed in a '
          'balance and the sea is measured by a measure. The prophet David '
          'interpreted "Hasab" as computation or counting numbers.',
      '• መንፈሳዊና ሒሳባዊ ዓላማ፡ ባሕረ ሐሳብ ዘለዓለማዊው እግዚአብሔር ሌሊትንና '
          'መዓልትን እያፈራረቀ የሚመግበን መሆኑን በቍጥርና በስፍር የሚያስረዳ መጽሐፍ '
          'ነው። ጊዜን ከሳድሲት፣ ኃምሲት፣ ራብዒት፣ ሣልሲት፣ ካልዒት፣ ኬክሮስ፣ '
          'ሰዓት፣ ዕለት፣ ሳምንት፣ ወርና ዓመት አጠቃልሎ ያሰላል።\n'
          '• ሦስቱ የባሕረ ሐሳብ ክፍሎች፡ ትምህርቱ እንደ ባሕር አዝዋሪት ውስጡ '
          'ጥልቅ፣ ምሥጢሩ ረቂቅ ስለሆነ የሐሳበ ዘመን መተርጉማን ሦስቱን አርእስት '
          'አንድ መጽሐፍ አድርገው ባሕረ ሐሳብ ብለው ሰይመውታል።\n'
          '• መርሐ ዕዉር (Guide for the Blind)፡ አላዋቂዎችን መርቶ ወደ ዕውቀት '
          'ደረጃ የሚያደርስ መጽሐፍ ነው። የአጽዋመትንና የበዓላትን አወጣጥ፣ '
          'ኢየዓርጋቸውንና ኢይወርዳቸውን፣ አበቅቴን፣ መጥቅዕንና ጥንተዮንን '
          'አቈጣጠር በዝርዝር ያስረዳል።\n'
          '• ሐሳበ አቡሻህር፡ አቡሻህር የተባለ ሊቅ የጻፈው ሲሆን የፀሐይን፣ '
          'የጨረቃንና የከዋክብትን እንዲሁም የሥነ ፈለክን ነገር ይናገራል። ቀመረ '
          'ትራፋተ ዐውድን፣ ቀመረ ዐረብንና ሰባቱን የቍጥር ቤቶች ያጠቃልላል።\n'
          '• ሐሳበ ፈለክ፡ የብርሃናቱን (ፀሐይ፣ ጨረቃ፣ ከዋክብት) መመላለስ '
          'እንዲሁም ሐሳበ ነፋሳትን ይመለከታል።',
      '• Theological & mathematical purpose: Bahire Hasab demonstrates through '
          'exact numbers and measurements how the eternal God governs the world. '
          'It calculates the alternation of day and night by breaking time down '
          'into precise microscopic fractions: sadsit, hamsit, rabi\'it, salsit, '
          'kal\'it, kekros, hour, day, week, month, and year.\n'
          '• The three branches: because the study is as profound and mysterious '
          'as a sea whirlpool, scholars of time-computation combined its three '
          'subjects into one comprehensive book named Bahire Hasab.\n'
          '• Merha Iwur (Guide for the Blind): leads the unlearned to knowledge. '
          'It contains the complete rules for the dates of fasts and feasts, their '
          'upper/lower limits (Iyareg, Iyiwerid), and variables like Abekte, '
          'Metki, and Tinteyon.\n'
          '• Hasabe Abushakir: by the scholar Abushakir, covering the sun, moon, '
          'stars, and astronomy, plus the lunar and solar remainders (Tirafate '
          'Awd, Kemere Areb) and the seven houses of numbers.\n'
          '• Hasabe Felek: strictly the movements and cycles of the luminaries, '
          'including the computation of the winds (Hasabe Nefasat).',
    ),
    (
      'የኢትዮጵያ የቀን አቈጣጠር (አዕዋዳት)',
      'The Ethiopian Calendar (Awdadat)',
      'ዐውድ ማለት ዙርያ፣ ክበብ፣ ከበር እስከ በር ካመት እስካመት ያለ ማለት ነው፤ '
          'በብዙ ቁጥር ሲነገር አዕዋዳት ይባላል። ለዓመተ ዓለም መቍጠርያ '
          'መስፈርያ የሚሆኑ ሰባት አዕዋዳት አሉ፤ ዐውደ ጳጉሜን ሲታከልበት '
          'ስምንት ይሆናሉ።',
      'The Ethiopian calendar measures the Era of the World using fundamental '
          'cyclical measurements known as Awdadat (አዕዋዳት). The term Awd '
          '(ዐውድ) means a circumference, circle, or cycle moving from year to '
          'year. There are seven primary cycles, which become eight when the '
          'cycle of Pagume is included.',
      '• ዐውደ ዕለት፡ የሰባት ዕለታት ዑደት ነው። ጥንተ ዕለት (የዕለት '
          'መዠመርያ) ከሚባለው ከእሑድ ተነሥቶ ቅዳሜ ይጠናቀቃል።\n'
          '• ዐውደ ወርኅ፡ በፀሐይ ዘወትር 30 ዕለት ነው። በጨረቃ ደግሞ አንድ '
          'ጊዜ 29 ቀን፣ አንድ ጊዜ 30 ቀን ይሆናል።\n'
          '• ዐውደ ዓመት፡ በፀሐይ 365 ዕለት ከ15 ኬክሮስ ከ6 ካልዒት ሲሆን፣ '
          'በጨረቃ ደግሞ 354 ዕለት 22 ኬክሮስ፣ 1 ካልዒት፣ 37 ሣልሲት፣ 52 '
          'ራብዒትና 48 ኃምሲት ነው።\n'
          '• ዐውደ ጳጉሜን፡ 4 ዓመት ነው፤ እያንዳንዱ ዓመትም በአራቱ '
          'ወንጌላውያን ስም ተሰይሟል።\n'
          '• ዐውደ አበቅቴ፡ 19 ዘመን ነው። በዚህ ፀሐይና ጨረቃ ዐውደ '
          'ዓመታቸውን ፈጽመው በተፈጠሩበት ኆኅት ተራክቦ ያደርጉበታል።\n'
          '• ዐውደ ፀሐይ፡ 28 ዓመት ነው። በዚህ ዕለት፣ ወንጌላዊ ማቴዎስና '
          'ፀሐይ ይገናኙበታል።\n'
          '• ዐውደ ማኅተም፡ 76 ዓመት ነው። በዚህ አበቅቴና ወንጌላዊ '
          'ይገናኙበታል፤ አበቅቴ 18፣ ወንጌላዊው ዮሐንስ ነው።\n'
          '• ዐውደ ቀመር፡ 532 ዓመት ነው። በዚህ ዕለት፣ አበቅቴና ወንጌላዊ '
          'ይገናኙበታል፤ ዐውዱ በዘመነ ማቴዎስ በማክሰኞ ተዠምሮ በ532ኛው '
          'ዓመት በዘመነ ዮሐንስ በሰኞ ይፈጸማል።',
      '• Awde Elet (Cycle of Days): the 7-day weekly cycle, beginning from Sunday '
          '(the "Root of Days", ጥንተ ዕለት) and ending on Saturday.\n'
          '• Awde Werh (Cycle of the Month): a solar month is always exactly 30 '
          'days; the lunar month alternates between 29 and 30 days.\n'
          '• Awde Amet (Cycle of the Year): the solar year is 365 days, 15 kekros, '
          'and 6 kal\'it; the lunar year is 354 days, 22 kekros, 1 kal\'it, 37 '
          'salsit, 52 rabi\'it, and 48 hamsit.\n'
          '• Awde Pagume: a 4-year cycle, each year named after an Evangelist in '
          'order. • Awde Abekte: a 19-year cycle; at its end the sun and moon meet '
          'exactly at the "gate" (ኆኅት) where they were created.\n'
          '• Awde Tsehay: a 28-year cycle in which the day, the Evangelist '
          '(Matthew), and the sun align.\n'
          '• Awde Mahtem: a 76-year cycle in which the Abekte and the Evangelist '
          'align; it acts as a seal (ማኅተም) ending with Abekte 18 and Evangelist '
          'John.\n'
          '• Awde Kemer: the 532-year grand cycle in which Abekte, Evangelist, and '
          'day all align. It begins on a Tuesday in the year of Matthew and '
          'resets after 532 years, finishing on a Monday in the year of John.',
    ),
    (
      'የጳጉሜንና የዘመን መለወጫ ሥርዓት',
      'Leap Years and Pagume',
      'ዐውደ ጳጉሜን 4 ዓመት ነው። እያንዳንዱ ዓመትም በአራቱ ወንጌላውያን '
          'ስም ተሰይሟል፤ መጀመሪያው ማቴዎስ፣ ሁለተኛው ማርቆስ፣ ሦስተኛው '
          'ሉቃስ፣ አራተኛው ዮሐንስ ነው።',
      'The cycle governing the intercalary month is the 4-year Awde Pagume '
          '(ዐውደ ጳጉሜን). Each year is dedicated to one of the four Evangelists '
          'in order: Matthew, Mark, Luke, and John.',
      '• ዓመተ ወንጌላውያንን ለማወቅ ዓመተ ዓለም ለአራት ክፍል ይከፈላል።\n'
          '• 1 ዓመት ቢተርፍ ወንጌላዊው ማቴዎስ፣ ጳጉሜን 5 ይሆናል።\n'
          '• 2 ዓመት ቢተርፍ ወንጌላዊው ማርቆስ፣ ጳጉሜን 5 ይሆናል።\n'
          '• 3 ዓመት ቢተርፍ ወንጌላዊው ሉቃስ፣ ጳጉሜን 5 ይሆናል።\n'
          '• ክፍያው እኩል ሆኖ ምንም ባይተርፍ ያንጊዜ ወንጌላዊው ዮሐንስ፣ '
          'ጳጉሜን 6 ይሆናል።\n'
          '• አዕዋዲት (ዕለተ ምርያ)፡ 5ኛይቱ ጳጉሜን ዓመቱን የምታዘዋውር '
          'የምታለዋውጥ ቀን ናት።\n'
          '• ሠግረ ዮሐንስ (መጠነ ራብዕት)፡ 6ኛይቱ ጳጉሜን ሲሆን ዮሐንስ '
          'ተራምዶ የሚውልበት ቀን ማለት ነው።\n'
          '• የ6ኛው ጳጉሜን መገኛ፡ 15 ኬክሮስ በ4 ሲባዛ 60 ኬክሮስ ሆኖ አንድ '
          'መዓልት ይባላል። በአንድ ዓመት የተገኘው 3 ሰዓተ መዓልትና 3 ሰዓተ '
          'ሌሊት (6 ሰዓት) በአራት ዓመት 24 (6×4) ሰዓት ሆኖ አንድ ዕለት '
          'ይባላል፤ ይኸውም 6ኛው ጳጉሜን ነው።',
      '• To determine the Evangelist and whether Pagume has 5 or 6 days, the Era '
          'of the World (Amete Alem) is divided into 4 equal parts.\n'
          '• Remainder 1 → Matthew, and Pagume has 5 days.\n'
          '• Remainder 2 → Mark, and Pagume has 5 days.\n'
          '• Remainder 3 → Luke, and Pagume has 5 days.\n'
          '• No remainder (0) → John, and Pagume has 6 days.\n'
          '• The 5th day of Pagume is Elete Mirya (ዕለተ ምርያ) or A\'ewadit '
          '(አዕዋዲት): the day that cycles, rotates, or changes the year.\n'
          '• The 6th day of Pagume is Metene Rab\'it (መጠነ ራብዕት) or Segre '
          'Yohannes (ሠግረ ዮሐንስ): the day John steps on or passes.\n'
          '• The astronomy of the 6th day: each solar year exceeds 365 days by 15 '
          'kekros, which equals exactly 6 hours per year (3 of daylight and 3 of '
          'night). Over the 4-year cycle that accumulates to 24 hours (6 × 4 = '
          '24) — one full day, and this becomes the 6th day of Pagume.',
    ),
    (
      'ወንበር፣ አበቅቴ እና መጥቅዕ',
      'Wenber, Abektie and Metk',
      'ወንበር ማለት ገባር፣ ተረፈ ንኡስ ቀመር፣ ዓመተ አበቅቴ ማለት ነው። '
          'መሠረታዊ ቁጥር ሲሆን አበቅቴና መጥቅዕ ከወንበር ይገኛሉ፤ ዓመተ ዓለም '
          '(ወይም ዓመተ ምሕረት) በ19 ንኡስ ቀመር ሲከፈል የሚተርፈው ውጤት '
          'ወንበር ይባላል።',
      'Wenber (ወንበር) translates to "Base" — the remainder of the minor cycle, '
          'or the Year of the Abekte. It is the foundational number from which '
          'both the Abekte and the Metki are derived, found by dividing the Era '
          'of the World by the 19-year minor cycle and taking the remainder.',
      '• አበቅቴ (የዘመን ቁጥር ትርፍ)፡ ተረፈ ዓመት፣ ተረፈ ኍልቍ ወይም ተረፈ '
          'ጨረቃ ይባላል። በፀሐይ ዓመት 365 ቀንና በጨረቃ ዓመት 354 ቀን መካከል '
          'ያለው የ11 ቀን ልዩነት አበቅቴ ይባላል። አወጣጡ፡ ወንበር × 11 '
          '(ጥንተ አበቅቴ) ለ30 ዐውደ ወርኅ ሲከፈል ቀሪው አበቅቴ ነው '
          '— (ወንበር × 11) mod 30።\n'
          '• መጥቅዕ (አዋጅ መንገርያ ነጋሪት፣ ደወል)፡ ተዘዋዋሪዎቹ አጽዋማትና '
          'በዓላት የሚታወቁት በመጥቅዕ አማካይነት ነው። መጥቅዕ ከዕለታት '
          'ተውሳክ ጋር ተደምሮ ሲቈጠር ውጤቱ መባጃ ሐመር ይሆናል። አወጣጡ፡ '
          'ወንበር × 19 (ጥንተ መጥቅዕ) ለ30 ሲከፈል ቀሪው መጥቅዕ ነው '
          '— (ወንበር × 19) mod 30።\n'
          '• የ30 ደንብ፡ አበቅቴና መጥቅዕ አንድ ላይ ቢደመሩ ሁልጊዜ 30 '
          'ይሆናሉ፤ ከ30 አይወርዱም፣ ከ30 አይበልጡም።\n'
          '• የሚውልበት ወር፡ ከ14 በላይ ያለ መጥቅዕ በመስከረም፣ ከ14 በታች '
          'ያለ መጥቅዕ በጥቅምት ይውላል።',
      '• Abektie (አበቅቴ) — the "surplus number of the era": the exact 11-day '
          'difference between the 365-day solar year and the 354-day lunar year. '
          'Calculation: (Wenber × 11) mod 30.\n'
          '• Metk (መጥቅዕ) — the "announcing drum" (ነጋሪት) or "bell" (ደወል), '
          'originally the beginning of the Jewish new year. It is the variable '
          'through which all movable fasts and feasts are proclaimed; added to '
          'the weekday Tewsak it yields the Mebaja Hamer (መባጃ ሐመር), the anchor '
          'of the fasts. Calculation: (Wenber × 19) mod 30.\n'
          '• The Rule of 30: Abekte and Metki always add to exactly 30; they '
          'never exceed nor fall below 30.\n'
          '• Month routing: if the Metki is greater than 14 the date falls in '
          'Meskerem; if it is 14 or less it falls in Tikimt.',
    ),
    (
      'ዓመተ ወንጌላውያን',
      'Evangelist of the Year',
      'የ4 ዓመቱ ዐውደ ጳጉሜን በአራቱ ወንጌላውያን ስም ተሰይሟል፤ መጀመሪያው '
          'ማቴዎስ፣ ሁለተኛው ማርቆስ፣ ሦስተኛው ሉቃስ፣ አራተኛው ዮሐንስ። '
          'ስማቸውም የክርስቶስን ሥርዓተ ትስብእት ስለጻፉና ስላስተማሩ፣ በአራቱ '
          'መዓዝነ ዓለም ወንጌልን ስለሰበኩ ነው። ማቴዎስ፣ ማርቆስና ሉቃስ '
          'እያንዳንዳቸው 5 ጳጉሜን ይዘው ዮሐንስ ግን ለብቻው 6 ጳጉሜን ይዞ '
          'ይመላለሳል።',
      'The 4-year cycle of Pagume (Awde Pagume) is dedicated in order to the four '
          'Evangelists: Matthew, Mark, Luke, and John. They are so named because '
          'they wrote, taught, and preached the Gospel and the system of Christ\'s '
          'incarnation across the four corners of the world. Matthew, Mark, and '
          'Luke take 5 days of Pagume each, while John alone takes 6.',
      '• ዓመተ ወንጌላውያንን ለማወቅ ዓመተ ዓለም ለአራት ክፍል ይከፈላል።\n'
          '• ቀሪ 1 → ማቴዎስ፣ ጳጉሜን 5።\n'
          '• ቀሪ 2 → ማርቆስ፣ ጳጉሜን 5።\n'
          '• ቀሪ 3 → ሉቃስ፣ ጳጉሜን 5።\n'
          '• ቀሪ 0 → ዮሐንስ፣ ጳጉሜን 6።\n'
          '• የአራቱ ኪሩቤል አምሳል፡ ማቴዎስ በገጸ ሰብእ (ሰው)፣ ማርቆስ '
          'በገጸ አንበሳ፣ ሉቃስ በገጸ ላሕም (ላም/በሬ)፣ ዮሐንስ በገጸ ንስር '
          'ይመሰላሉ።',
      '• To find the Evangelist of the year, the Era of the World (Amete Alem) '
          'is divided by 4.\n'
          '• Remainder 1 → Matthew, Pagume 5.\n'
          '• Remainder 2 → Mark, Pagume 5.\n'
          '• Remainder 3 → Luke, Pagume 5.\n'
          '• Remainder 0 → John, Pagume 6.\n'
          '• The Cherubim symbolism: Matthew is the face of a Man (ገጸ ሰብእ), '
          'Mark of a Lion (ገጸ አንበሳ), Luke of an Ox (ገጸ ላሕም), and John of an '
          'Eagle (ገጸ ንስር) — mirroring the four Cherubim guarding the throne '
          'of God.',
    ),
    (
      'ዓመተ ዓለም እና አቡሻህር',
      'Amete Alem and Abushakir',
      'ዓመተ ዓለም ማለት መዋዕለ ዓለም ወይም የዘመናት ድምር ነው። ከፍጥረተ ዓለም '
          'እስከ ዛሬ ያለ የዘመን ድምር ሲሆን ከጌታ ልደት በፊት ያለውን 5500 ዓመት '
          'እና ከልደት በኋላ ያለውን ዓመት በመደመር ይገኛል (ምሳሌ፡ 5500 + 2004 '
          '= 7504)።',
      'Amete Alem (ዓመተ ዓለም) means the Era of the World or the days of the '
          'world (Mewae\'le Alem). It is the total sum of years from creation to '
          'today, calculated by adding the 5,500 years before Christ to the years '
          'after Christ (e.g., 5500 + 2004 = 7504).',
      '• የዘመናት ክፍፍል፡ ከፍጥረተ ዓለም እስከ ልደተ ክርስቶስ ያሉት 5500 '
          'ዘመናት ዓመተ ፍዳ፣ ዓመተ ኵነኔ ወይም ዘመነ ብሉይ ይባላሉ። ከልደተ '
          'ክርስቶስ እስከ ዛሬ ያለው ደግሞ ዓመተ ምሕረት፣ ዓመተ ሥጋዌ ወይም '
          'ዘመነ ሐዲስ ይባላል።\n'
          '• ዓመተ ምሕረት የመባሉ ምስጢር፡ ሰው በዚህ ዓለም ንስሐ ገብቶ ምግባር '
          'ትሩፋት ቢሠራ ከእግዚአብሔር ይቅርታን ስለሚያገኝ ዓመተ ዓለምም '
          'ዓመተ ምሕረት ይባላል።\n'
          '• አቡሻህር (በዓለ ስብሐት / በዓለ አኰቴት)፡ ሙሉ ስሙ አቡሻህር ኢብን '
          'ቡትሩስ ራሒብ የተባለ ዮሐንስ በ13ኛው ምእት ዓመት በእስክንድሪያ '
          'የጻፈው የቁጥር መጽሐፍ ነው። መጽሐፉም በዚሁ ሊቅ ስም ተሰይሟል።\n'
          '• ይዘቱ፡ የፀሐይን፣ የጨረቃንና የከዋክብትን፣ የሥነ ፈለክን ነገር '
          'በጠቅላላው ይናገራል፤ ቀመረ ትራፋተ ዐውድን፣ ቀመረ ዐረብንና ሰባቱን '
          'የቍጥር ቤቶች (የጨረቃ ጥንተዮን) ያጠቃልላል።',
      '• The two eras: the 5,500 years from creation until Christ are the Era of '
          'Judgment (Amete Fida), Amete Kunene, or the Era of the Old Testament '
          '(Zemene Biluy). From the birth of Christ to today is the Era of Mercy '
          '(Amete Mihret), Amete Sigawe, or the Era of the New Testament (Zemene '
          'Hadis).\n'
          '• Theological note: Amete Alem is sometimes broadly called Amete '
          'Mihret, because a person who repents and does good deeds receives mercy '
          'and forgiveness from God.\n'
          '• Abushakir (አቡሻህር — "Festival of Praise / Thanksgiving", በዓለ '
          'ስብሐት / በዓለ አኰቴት): a profound book of computus written by '
          'Yohannes — Abu Shakir Ibn Butrus Rahib — who lived in Alexandria in '
          'the 13th century.\n'
          '• Contents: astronomy of the sun, moon, and stars; the remainders of '
          'the lunar and solar cycles (Kemere Tirafate Awd), the Arab lunar '
          'computations (Kemere Areb), and the seven houses of numbers used to '
          'find the lunar starting day (Tinteyon).',
    ),
    (
      'የአጽዋማትና የበዓላት ሥርዓት',
      'The Fasting Seasons and Movable Feasts',
      'በዘመነ ሐዲስ የተሠሩ ተዘዋዋሪ አጽዋማትና በዓላት 11 ሲሆኑ መሠረታቸው '
          'ጾመ ነነዌ ነው። እንደ ቅዱስ ድሜጥሮስ ሥርዓት ጾመ ነነዌ፣ ዐቢይ ጾምና '
          'ጾመ ሐዋርያት ከሰኞ፤ ደብረ ዘይት፣ ሆሣዕና፣ ትንሣኤና ጰራቅሊጦስ '
          'ከእሑድ፤ ረክበ ካህናትና ጾመ ድኅነት ከረቡዕ፤ ዕርገት ከኀሙስ፤ ስቅለት '
          'ከዓርብ ይወጣሉ።',
      'The movable fasts and feasts of the New Testament (11 in number) are '
          'derived from the anchor of Tsome Nenewe (the Fast of Nineveh), which '
          'always falls on a Monday. By the tradition of Demetrius of Alexandria, '
          'penitential fasts begin on Mondays or Wednesdays while joyous feasts '
          'land on Sundays or on specific days for historical alignment.',
      '• ጾመ ነነዌ፡ በጥር ወይም በየካቲት የሚውል የሦስት ቀናት ጾም ሲሆን '
          'የዓመቱ መሠረትና ማዕከል ነው።\n'
          '• በአተ ጾም (ዐቢይ ጾም / ሁዳዴ)፡ ባለ55 ቀን ማዕከላዊ ጾም በሰኞ '
          'ይጀምራል።\n'
          '• ደብረ ዘይት፡ ከመጋቢት 28–ሚያዝያ 2 በእሑድ የሚውል የጾሙ አጋማሽ '
          'በዓል ነው።\n'
          '• ሆሣዕና፡ ከመጋቢት 19–ሚያዝያ 23 በእሑድ ይከበራል።\n'
          '• ስቅለት፡ ከመጋቢት 24–ሚያዝያ 28 በዓርብ ይታሰባል።\n'
          '• ትንሣኤ (ፋሲካ)፡ ከመጋቢት 26–ሚያዝያ 30 በእሑድ የሚከበር ታላቅ '
          'በዓል ነው።\n'
          '• ረክበ ካህናት፡ ከሚያዝያ 20–ግንቦት 24 በረቡዕ ይውላል።\n'
          '• ዕርገት፡ ከግንቦት 5–ሠኔ 9 በኀሙስ (ትንሣኤ + 39 ቀን) ይከበራል።\n'
          '• ጰራቅሊጦስ (በዓለ 50)፡ ከግንቦት 15–ሠኔ 19 በእሑድ ይውላል።\n'
          '• ጾመ ሐዋርያት፡ ከግንቦት 16–ሠኔ 20 የሚጀምር።\n'
          '• ጾመ ድኅነት፡ ከግንቦት 18–ሠኔ 22 በረቡዕ የሚጀምር ሳምንታዊ '
          'ጾም ነው።\n'
          '• የብሉይ አምሳል መርገፍ፡ እንደ በድር፣ መጸለት፣ ጾመ ሙሴ፣ ፍሥሕ፣ '
          'ልበ ምድር፣ በዓለ ሰዊት ያሉ የብሉይ ጾማትና በዓላት ለሐዲሶቹ '
          'አምሳል መርገፎች ናቸው፤ ለምሳሌ መጸለት የበዓለ ጥምቀት፣ ልበ ምድር '
          'የትንሣኤ ምሳሌ ነው።',
      '• Tsome Nenewe (ጾመ ነነዌ): the primary anchor fast, always starting on a '
          'Monday in Tir or Yekatit.\n'
          '• Abiy Tsom (ዐቢይ ጾም — Great Lent): the 55-day central fasting period, '
          'always beginning on a Monday.\n'
          '• Debre Zeyit (ደብረ ዘይት): celebrated on a Sunday, marking mid-Lent '
          '(Megabit 28 – Miyazya 2).\n'
          '• Hosanna (ሆሣዕና — Palm Sunday): a Sunday one week before Easter '
          '(Megabit 19 – Miyazya 23).\n'
          '• Siklet (ስቅለት — Good Friday): the crucifixion, always a Friday '
          '(Megabit 24 – Miyazya 28).\n'
          '• Tinsae (ትንሣኤ — Easter): the Resurrection, always a Sunday (Megabit '
          '26 – Miyazya 30).\n'
          '• Rekbe Kahnat (ረክበ ካህናት): the gathering of the priests, on a '
          'Wednesday (Miyazya 20 – Ginbot 24).\n'
          '• Erget (ዕርገት — Ascension): 40 days after Easter, a Thursday (Ginbot 5 '
          '– Sene 9).\n'
          '• Peraqlitos (ጰራቅሊጦስ — Pentecost): 50 days after Easter, a Sunday '
          '(Ginbot 15 – Sene 19).\n'
          '• Tsome Hawaryat (ጾመ ሐዋርያት — Apostles\' Fast): begins on a Monday '
          'after Pentecost (Ginbot 16 – Sene 20).\n'
          '• Tsome Dihnet (ጾመ ድኅነት — Fast of Salvation): the weekly fasts '
          'which begin on a Wednesday (Ginbot 18 – Sene 22).\n'
          '• Old Testament prefigurations (አምሳል መርገፍ): Bedir, Metselet '
          '(prefigures Epiphany/Timkat), Tsome Muse (Lent), Fisih (Passover, '
          'prefigures the Crucifixion), Libe Midir (the Resurrection/Salvation), '
          'and Ba\'ale Sewit (Pentecost).',
    ),
    (
      'ተዘዋዋሪ በዓላት እንዴት እንደሚቆጠሩ',
      'How Movable Feasts Are Counted',
      'የዘመነ ሐዲስ ተዘዋዋሪ አጽዋማትና በዓላት የሚገኙት በመጥቅዕና በዕለታት '
          'ተውሳክ አማካይነት ከሚገኘው መባጃ ሐመር ተነሥቶ ነው። ተውሳኮች፡ '
          'ቅዳሜ=8፣ እሑድ=7፣ ሰኞ=6፣ ማክሰኞ=5፣ ረቡዕ=4፣ ኀሙስ=3፣ ዓርብ=2 ናቸው።',
      'All movable fasts and feasts of the New Testament are calculated from the '
          'Mebaja Hamer (መባጃ ሐመር), the generator number derived from the year\'s '
          'Metki and the weekday Tewsak. The fixed weekday Tewsaks are: '
          'Saturday=8, Sunday=7, Monday=6, Tuesday=5, Wednesday=4, Thursday=3, '
          'Friday=2.',
      '• እርምጃ 1 (መጥቅዕን መለየት)፡ ከ14 በላይ ያለ መጥቅዕ በመስከረም፣ ከ14 '
          'በታች ያለ መጥቅዕ በጥቅምት ይውላል።\n'
          '• እርምጃ 2 (የዕለታት ተውሳክ)፡ መጥቅዕ የዋለበትን ዕለት ለይቶ '
          'የዕለቱን ተውሳክ ማወቅ (ከላይ እንደተዘረዘረ)።\n'
          '• እርምጃ 3 (መባጃ ሐመር)፡ መጥቅዕ ከዕለታት ተውሳክ ጋር ተደምሮ '
          'ሲቈጠር ከ30 ቢተርፍ ትርፉ መባጃ ሐመር ይሆናል። ውጤቱም የጾመ ነነዌን '
          'መግቢያ ቀን ያመለክታል።\n'
          '• ቀሪዎቹን በዓላት ማውጣት፡ ከመባጃ ሐመር ጋር የየበዓላቱን ተውሳክ '
          'በመደመር፤ ድምሩ ከ30 በላይ ሲሆን 30 እየቀነሱ ወደ ቀጠለው ወር '
          'መሸጋገር።\n'
          '• የተዘዋዋሪ በዓላት ተውሳኮች፡ ዐቢይ ጾም=14፣ ደብረ ዘይት=11፣ '
          'ሆሣዕና=2፣ ስቅለት=7፣ ትንሣኤ=9፣ ረክበ ካህናት=3፣ ዕርገት=18፣ '
          'ጰራቅሊጦስ=28፣ ጾመ ሐዋርያት=29፣ ጾመ ድኅነት=1 ናቸው።',
      '• Step 1 (locate the Metk): if the Metki is greater than 14 it falls in '
          'Meskerem; if 14 or less it falls in Tikimt.\n'
          '• Step 2 (find the weekday Tewsak): determine the day of the week the '
          'Metki falls on and take that weekday\'s fixed Tewsak (see above).\n'
          '• Step 3 (calculate Mebaja Hamer): add the Metki to the weekday\'s '
          'Tewsak; if the sum exceeds 30, subtract 30. The result is the '
          'generator number which fixes the exact date of Tsome Nenewe in Yekatit '
          '(or Tir) — the anchor of the feast calendar.\n'
          '• Calculating the rest: add each feast\'s own Tewsak to the Mebaja '
          'Hamer; if the sum exceeds 30, subtract 30 and roll into the next '
          'month.\n'
          '• The New Testament Tewsak offsets: Abiy Tsom=14, Debre Zeyit=11, '
          'Hosanna=2, Siklet=7, Tinsae=9, Rekbe Kahnat=3, Erget=18, '
          'Peraqlitos=28, Tsome Hawaryat=29, Tsome Dihnet=1.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.t('ትምህርት', 'Learn'))),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final (am, en, amIntro, enIntro, amBody, enBody) in _sections)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.isAmharic ? am : en,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF8C1F28),
                      ),
                    ),
                    Text(
                      L10n.isAmharic ? en : am,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF6E4B12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      L10n.isAmharic ? amIntro : enIntro,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      L10n.isAmharic ? amBody : enBody,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          Card(
            color: const Color(0xFFFFF3D6),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.t('የአፕ ስሌት ማስታወሻ', 'App calculation notes'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    L10n.isAmharic
                        ? '• መሠረታዊ ሕጎች፡ ማንኛውም የዘመን ስሌት የሚጀምረው የኢትዮጵያኛን '
                              'ዓመት (ዓመተ ምሕረት) ከፍጥረተ ዓለም ጋር በማያያዝ '
                              '5500 በመደመር ዓመተ ዓለምን በማውጣት ነው።\n'
                              '• ወንበር = (ዓመተ ዓለም ÷ 19 ቀሪ) − 1፤ ቀሪው 0 ከሆነ '
                              'ወንበር 18 ይሆናል።\n'
                              '• አበቅቴ = (ወንበር × 11) mod 30፣ መጥቅዕ = (ወንበር × '
                              '19) mod 30፤ ድምራቸው ሁልጊዜ 30 ነው።\n'
                              '• የወር ማሻገር (Rollover)፡ ድምሩ ከ30 በላይ ሲሆን 30 '
                              'በመቀነስ ቀኑ ወደ ቀጠለው ወር ይሸጋገራል።\n'
                              '• ማረጋገጫ ምሳሌ፡ 2001 ዓ.ም. → ዓመተ ዓለም 7501፣ '
                              'ወንበር 14፣ አበቅቴ 4፣ መጥቅዕ 26።\n'
                              '• የዘመን መለወጫ (ዝለት ዓመት)፡ ዓመተ ዓለም በ4 '
                              'ሲካፈል ቀሪው 0 ሲሆን ዘመነ ዮሐንስ ስለሆነ ጳጉሜን '
                              '6 ቀን ይሆናል።\n'
                              '• አፕ የኢትዮጵያ አቆጣጠርን (Beyene–Kudlek፣ '
                              '1724221) እና የፋሲካን የቤተክርስቲያን ሒሳብ '
                              'በመጠቀም ተዘዋዋሪ በዓላትን ከተውሳኮቹ ጋር '
                              'ተመሳሳይ የሆነ ውጤት ያስገኛል።'
                        : '• Foundational rules: all reckoning begins by '
                              'converting the Ethiopian year (Amete Mihret) into '
                              'the Era of the World (Amete Alem) by adding 5,500.\n'
                              '• Wenber = (Amete Alem ÷ 19 remainder) − 1, '
                              'defaulting to 18 when the remainder is 0.\n'
                              '• Abekte = (Wenber × 11) mod 30 and Metki = (Wenber '
                              '× 19) mod 30; their sum is always 30.\n'
                              '• Rollover validation: any addition exceeding 30 '
                              'automatically shifts into the next Ethiopian month '
                              'by subtracting 30.\n'
                              '• Worked check: 2001 E.C. → Amete Alem 7501, Wenber '
                              '14, Abekte 4, Metki 26.\n'
                              '• Leap-year trigger: divide the Amete Alem by 4; a '
                              'zero remainder designates the year of John, so '
                              'Pagume renders 6 days instead of 5.\n'
                              '• The app converts the Ethiopian calendar '
                              '(Beyene–Kudlek, epoch 1724221) and computes the '
                              'moveable feasts with the same Tewsak table used by '
                              'the church.',
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      L10n.t('በ ኦርያሬስ የተሰራ', 'Developed by Oryares'),
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: Colors.black.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
