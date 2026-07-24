import 'package:flutter/material.dart';
import 'screens/quran_screen.dart';
import 'screens/sholat_screen.dart';
import 'screens/asma_screen.dart';
import 'screens/zikir_screen.dart';

void main() {
  runApp(const AlQuranDigitalApp());
}

class AlQuranDigitalApp extends StatelessWidget {
  const AlQuranDigitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF059669);
    return MaterialApp(
      title: "Al-Qur'an Digital",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: emerald,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: emerald,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020617),
      ),
      themeMode: ThemeMode.system,
      home: const RootNav(),
    );
  }
}

class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _index = 0;

  // Tab ke-1 (Yasin) langsung membuka Surah 36 lewat parameter initialSurahNo
  final _screens = const [
    QuranScreen(),
    QuranScreen(initialSurahNo: 36, isYasinShortcut: true),
    SholatScreen(),
    AsmaScreen(),
    ZikirScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Text('📖', style: TextStyle(fontSize: 20)), label: "Qur'an"),
          NavigationDestination(icon: Text('📗', style: TextStyle(fontSize: 20)), label: "Yasin"),
          NavigationDestination(icon: Text('🕌', style: TextStyle(fontSize: 20)), label: "Sholat"),
          NavigationDestination(icon: Text('✨', style: TextStyle(fontSize: 20)), label: "Asmaul Husna"),
          NavigationDestination(icon: Text('📿', style: TextStyle(fontSize: 20)), label: "Zikir"),
        ],
      ),
    );
  }
}
