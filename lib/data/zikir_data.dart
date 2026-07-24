class ZikirItem {
  final String judul;
  final String arab;
  final String latin;
  final String arti;
  final int target;

  const ZikirItem({
    required this.judul,
    required this.arab,
    required this.latin,
    required this.arti,
    required this.target,
  });
}

const List<ZikirItem> zikirData = [
  ZikirItem(
    judul: "Istighfar",
    arab: "أَسْتَغْفِرُ اللهَ الْعَظِيمَ",
    latin: "Astaghfirullahal 'adzim",
    arti: "Aku memohon ampun kepada Allah Yang Maha Agung.",
    target: 3,
  ),
  ZikirItem(
    judul: "Istighfar Lengkap",
    arab: "أَسْتَغْفِرُ اللهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ",
    latin: "Astaghfirullahalladzi la ilaha illa huwal hayyul qayyumu wa atubu ilaih",
    arti: "Aku memohon ampun kepada Allah, tiada Tuhan selain Dia Yang Maha Hidup lagi Berdiri Sendiri.",
    target: 3,
  ),
  ZikirItem(
    judul: "Tahlil Singkat",
    arab: "لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
    latin: "La ilaha illallahu wahdahu la syarika lahu, lahul mulku wa lahul hamdu yuhyi wa yumitu wa huwa 'ala kulli syai'in qadir",
    arti: "Tiada Tuhan selain Allah, Yang Maha Esa, tiada sekutu bagi-Nya, bagi-Nya kerajaan dan pujian, Dia menghidupkan dan mematikan, dan Dia Maha Kuasa atas segala sesuatu.",
    target: 10,
  ),
  ZikirItem(
    judul: "Doa Selamat",
    arab: "اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ",
    latin: "Allahumma antas salam wa minkas salam tabarakta ya dzal jalali wal ikram",
    arti: "Ya Allah, Engkau adalah Penyelamat, dan dari-Mu keselamatan, Maha Suci Engkau wahai Pemilik keagungan dan kemuliaan.",
    target: 1,
  ),
  ZikirItem(judul: "Tasbih", arab: "سُبْحَانَ اللهِ", latin: "Subhanallah", arti: "Maha Suci Allah", target: 33),
  ZikirItem(judul: "Tahmid", arab: "الْحَمْدُ لِلهِ", latin: "Alhamdulillah", arti: "Segala Puji bagi Allah", target: 33),
  ZikirItem(judul: "Takbir", arab: "اللهُ أَكْبَرُ", latin: "Allahu Akbar", arti: "Allah Maha Besar", target: 33),
  ZikirItem(judul: "Tahlil Akhir", arab: "لَا إِلَهَ إِلَّا اللهُ", latin: "La ilaha illallah", arti: "Tiada Tuhan selain Allah", target: 33),
];
