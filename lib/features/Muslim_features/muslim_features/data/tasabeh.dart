import 'package:flutter/material.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/azkar_screen.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/doaa.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/hadith.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/quraan.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/tasbih.dart';

class Tasbeh {
  String category;
  String count;
  String description;
  String reference;
  String content;

  Tasbeh({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });
}

List<Tasbeh> tasabeh_list = [
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "يكتب له ألف حسنة أو يحط عنه ألف خطيئة.",
    reference: "",
    content: "سُبْحَانَ اللَّهِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
    reference: "",
    content: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "تَمْلَآَنِ مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ.",
    reference: "",
    content: "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "غرست له نخلة في الجنة.",
    reference: "",
    content: "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "ثقيلتان في الميزان حبيبتان إلى الرحمن.",
    reference: "",
    content: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان.",
    reference: "",
    content: "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ.",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "كنز من كنوز الجنة.",
    reference: "",
    content: "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "تملأ ميزان العبد بالحسنات.",
    reference: "",
    content: "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
    reference: "",
    content: "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "لفعل الرسول صلى الله عليه وسلم.",
    reference: "",
    content: "أستغفر الله",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "أنهن أحب الكلام الى الله، ومكفرات للذنوب، وغرس الجنة، وجنة لقائلهن من النار، وأحب الى النبي عليه السلام مما طلعت عليه الشمس، والْبَاقِيَاتُ الْصَّالِحَات.",
    reference: "",
    content: "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "أفضل الذكر لا إله إلاّ الله.",
    reference: "",
    content: "لَا إِلَهَ إِلَّا اللَّهُ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "من قال الله أكبر كتبت له عشرون حسنة وحطت عنه عشرون سيئة. الله أكبر من كل شيء.",
    reference: "",
    content: "الْلَّهُ أَكْبَرُ",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "خير الدنيا والآخرة",
    reference: "",
    content: "سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي.",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "قَالَ النَّبِيُّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ \"عَجِبْتُ لَهَا ، فُتِحَتْ لَهَا أَبْوَابُ السَّمَاءِ\".",
    reference: "",
    content: "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً.",
  ),
  Tasbeh(
    category: "تسابيح",
    count: "100",
    description: "في كل مره تحط عنه عشر خطايا ويرفع له عشر درجات ويصلي الله عليه عشرا وتعرض على الرسول صلى الله عليه وسلم.",
    reference: "",
    content: "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ.",
  ),
];
List<Widget> muslim_features = [
    quranlist(),
    hadith(),
    TasbihScreen(),
    DoaaScreen(),
    Azkar(),

  ];