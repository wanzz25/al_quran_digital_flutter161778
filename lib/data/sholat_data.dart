import 'package:flutter/material.dart';

class NiatSholat {
  final String arab;
  final String latin;
  final String arti;
  const NiatSholat({required this.arab, required this.latin, required this.arti});
}

class SholatWaktuItem {
  final String icon;
  final String nama;
  final int rakaat;
  final String jenis;
  final String waktu;
  final List<Color> gradient;
  final NiatSholat niat;

  const SholatWaktuItem({
    required this.icon,
    required this.nama,
    required this.rakaat,
    required this.jenis,
    required this.waktu,
    required this.gradient,
    required this.niat,
  });
}

const List<SholatWaktuItem> sholatWaktuData = [
  SholatWaktuItem(
    icon: "🌅",
    nama: "Subuh",
    rakaat: 2,
    jenis: "Jahr (Bacaan Keras)",
    waktu: "Terbit fajar shadiq hingga terbit matahari",
    gradient: [Color(0xFFF59E0B), Color(0xFFF97316)],
    niat: NiatSholat(
      arab: "أُصَلِّي فَرْضَ الصُّبْحِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
      latin: "Ushalli fardhash shubhi rak'ataini mustaqbilal qiblati adaa'an lillahi ta'ala",
      arti: "Aku niat sholat fardhu Subuh, dua rakaat, menghadap kiblat, karena Allah Ta'ala.",
    ),
  ),
  SholatWaktuItem(
    icon: "☀️",
    nama: "Dzuhur",
    rakaat: 4,
    jenis: "Sirr (Bacaan Pelan)",
    waktu: "Matahari tergelincir hingga bayangan benda sama panjang",
    gradient: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
    niat: NiatSholat(
      arab: "أُصَلِّي فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
      latin: "Ushalli fardhazh zhuhri arba'a raka'atin mustaqbilal qiblati adaa'an lillahi ta'ala",
      arti: "Aku niat sholat fardhu Dzuhur, empat rakaat, menghadap kiblat, karena Allah Ta'ala.",
    ),
  ),
  SholatWaktuItem(
    icon: "🌤️",
    nama: "Ashar",
    rakaat: 4,
    jenis: "Sirr (Bacaan Pelan)",
    waktu: "Bayangan lebih panjang dari benda hingga menjelang terbenam matahari",
    gradient: [Color(0xFFFB923C), Color(0xFFEA580C)],
    niat: NiatSholat(
      arab: "أُصَلِّي فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
      latin: "Ushalli fardhal 'ashri arba'a raka'atin mustaqbilal qiblati adaa'an lillahi ta'ala",
      arti: "Aku niat sholat fardhu Ashar, empat rakaat, menghadap kiblat, karena Allah Ta'ala.",
    ),
  ),
  SholatWaktuItem(
    icon: "🌇",
    nama: "Maghrib",
    rakaat: 3,
    jenis: "Jahr (Bacaan Keras)",
    waktu: "Matahari terbenam hingga hilangnya cahaya merah di ufuk",
    gradient: [Color(0xFFFB7185), Color(0xFFE11D48)],
    niat: NiatSholat(
      arab: "أُصَلِّي فَرْضَ الْمَغْرِبِ ثَلَاثَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
      latin: "Ushalli fardhal maghribi tsalatsa raka'atin mustaqbilal qiblati adaa'an lillahi ta'ala",
      arti: "Aku niat sholat fardhu Maghrib, tiga rakaat, menghadap kiblat, karena Allah Ta'ala.",
    ),
  ),
  SholatWaktuItem(
    icon: "🌙",
    nama: "Isya",
    rakaat: 4,
    jenis: "Jahr (Bacaan Keras)",
    waktu: "Hilangnya cahaya merah hingga terbit fajar shadiq",
    gradient: [Color(0xFF818CF8), Color(0xFF4F46E5)],
    niat: NiatSholat(
      arab: "أُصَلِّي فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
      latin: "Ushalli fardhal 'isya-i arba'a raka'atin mustaqbilal qiblati adaa'an lillahi ta'ala",
      arti: "Aku niat sholat fardhu Isya, empat rakaat, menghadap kiblat, karena Allah Ta'ala.",
    ),
  ),
];

class BacaanSholatItem {
  final String judul;
  final String arab;
  final String latin;
  final String arti;
  final String? ulang;
  const BacaanSholatItem({required this.judul, required this.arab, required this.latin, required this.arti, this.ulang});
}

const List<BacaanSholatItem> sholatBacaanData = [
  BacaanSholatItem(
    judul: "1. Niat",
    arab: "(sesuai niat waktu sholat masing-masing)",
    latin: "",
    arti: "Niat diucapkan dalam hati bersamaan dengan takbiratul ihram.",
  ),
  BacaanSholatItem(
    judul: "2. Takbiratul Ihram",
    arab: "اللهُ أَكْبَرُ",
    latin: "Allahu Akbar",
    arti: "Allah Maha Besar — mengangkat kedua tangan sejajar telinga sambil mengucapkan takbir, menandai dimulainya sholat.",
  ),
  BacaanSholatItem(
    judul: "3. Doa Iftitah",
    arab: "اللَّهُمَّ بَاعِدْ بَيْنِي وَبَيْنَ خَطَايَايَ كَمَا بَاعَدْتَ بَيْنَ الْمَشْرِقِ وَالْمَغْرِبِ",
    latin: "Allahumma ba'id baini wa baina khathayaya kama ba'adta bainal masyriqi wal maghrib",
    arti: "Ya Allah, jauhkanlah antara aku dan kesalahan-kesalahanku sebagaimana Engkau menjauhkan antara timur dan barat.",
  ),
  BacaanSholatItem(
    judul: "4. Al-Fatihah",
    arab: "بِسْمِ اللهِ الرَّحْمَنِ الرَّحِيمِ",
    latin: "Bismillahirrahmanirrahim, lalu membaca surat Al-Fatihah hingga selesai",
    arti: "Wajib dibaca di setiap rakaat, boleh dilanjutkan dengan surat pendek pada rakaat pertama & kedua.",
  ),
  BacaanSholatItem(
    judul: "5. Ruku",
    arab: "سُبْحَانَ رَبِّيَ الْعَظِيمِ وَبِحَمْدِهِ",
    latin: "Subhana rabbiyal 'adzimi wa bihamdih",
    arti: "Maha Suci Tuhanku Yang Maha Agung dan segala puji bagi-Nya.",
    ulang: "Dibaca 3x, punggung sejajar & kedua tangan memegang lutut",
  ),
  BacaanSholatItem(
    judul: "6. I'tidal",
    arab: "سَمِعَ اللهُ لِمَنْ حَمِدَهُ ۝ رَبَّنَا وَلَكَ الْحَمْدُ",
    latin: "Sami'allahu liman hamidah, rabbana wa lakal hamdu mil'as samawati wa mil'al ardh",
    arti: "Allah mendengar orang yang memuji-Nya. Ya Tuhan kami, bagi-Mu segala puji sepenuh langit dan bumi.",
  ),
  BacaanSholatItem(
    judul: "7. Sujud",
    arab: "سُبْحَانَ رَبِّيَ الْأَعْلَى وَبِحَمْدِهِ",
    latin: "Subhana rabbiyal a'la wa bihamdih",
    arti: "Maha Suci Tuhanku Yang Maha Tinggi dan segala puji bagi-Nya.",
    ulang: "Dibaca 3x, tujuh anggota badan menyentuh lantai",
  ),
  BacaanSholatItem(
    judul: "8. Duduk Antara Dua Sujud",
    arab: "رَبِّ اغْفِرْ لِي وَارْحَمْنِي وَاجْبُرْنِي وَارْفَعْنِي وَارْزُقْنِي وَاهْدِنِي وَعَافِنِي وَاعْفُ عَنِّي",
    latin: "Rabbighfirli warhamni wajburni warfa'ni warzuqni wahdini wa 'afini wa'fu 'anni",
    arti: "Ya Tuhanku, ampunilah aku, kasihanilah aku, cukupkanlah kekuranganku, angkatlah derajatku, berilah aku rezeki, berilah aku petunjuk, sehatkanlah aku, dan maafkanlah aku.",
  ),
  BacaanSholatItem(
    judul: "9. Tasyahud Awal",
    arab: "التَّحِيَّاتُ الْمُبَارَكَاتُ الصَّلَوَاتُ الطَّيِّبَاتُ لِلَّهِ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللهِ وَبَرَكَاتُهُ",
    latin: "At-tahiyyatul mubarakatush shalawatuth thayyibatu lillah, assalamu 'alaika ayyuhan nabiyyu wa rahmatullahi wa barakatuh",
    arti: "Dibaca duduk tasyahud pada rakaat kedua (untuk sholat 3-4 rakaat), sebelum berdiri kembali.",
  ),
  BacaanSholatItem(
    judul: "10. Tasyahud Akhir",
    arab: "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ",
    latin: "Allahumma shalli 'ala Muhammad wa 'ala ali Muhammad kama shallaita 'ala Ibrahim",
    arti: "Dilanjutkan bacaan shalawat kepada Nabi Muhammad ﷺ pada rakaat terakhir, sebelum salam.",
  ),
  BacaanSholatItem(
    judul: "11. Salam",
    arab: "السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ اللهِ",
    latin: "Assalamu'alaikum warahmatullah",
    arti: "Menoleh ke kanan lalu ke kiri, menandai berakhirnya sholat.",
  ),
];
