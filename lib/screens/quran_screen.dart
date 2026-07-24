import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:audioplayers/audioplayers.dart';

/// TEKS AL-QUR'AN 100% OFFLINE.
/// Data diambil dari assets/quran/quran_id.json (harus didownload manual,
/// lihat README.md) — sudah berisi teks Arab + terjemahan Indonesia untuk
/// SELURUH 114 surah / 6.236 ayat dalam satu file, jadi tidak perlu internet
/// untuk membaca.
///
/// AUDIO MUROTAL tetap streaming dari internet (qori: Mishari Rashid
/// Alafasy, sumber: quranicaudio.com) karena file audio terlalu besar untuk
/// dibundle offline. Ini sesuai permintaan: teks manual/offline, audio API.

/// Cache global supaya file JSON cuma di-parse sekali selama app hidup.
List<dynamic>? _quranCache;

Future<List<dynamic>> _loadQuranData() async {
  if (_quranCache != null) return _quranCache!;
  final raw = await rootBundle.loadString('assets/quran/quran_id.json');
  _quranCache = jsonDecode(raw) as List<dynamic>;
  return _quranCache!;
}

String _audioUrlForSurah(int surahNumber) {
  final padded = surahNumber.toString().padLeft(3, '0');
  return 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/$padded.mp3';
}

class QuranScreen extends StatefulWidget {
  final int? initialSurahNo;
  final bool isYasinShortcut;
  const QuranScreen({super.key, this.initialSurahNo, this.isYasinShortcut = false});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<dynamic> _surahList = [];
  List<dynamic> _filtered = [];
  Map<String, dynamic>? _detail;
  bool _loadingList = true;
  bool _loadingDetail = false;
  String? _error;
  final _searchCtrl = TextEditingController();
  final _player = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _init();
    _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  Future<void> _init() async {
    try {
      final data = await _loadQuranData();
      setState(() {
        _surahList = data;
        _filtered = data;
        _loadingList = false;
      });
      if (widget.initialSurahNo != null) {
        _openSurah(widget.initialSurahNo!);
      }
    } catch (e) {
      setState(() {
        _error = 'File assets/quran/quran_id.json belum ada / gagal dibaca.\n'
            'Cek lagi README.md untuk link download & lokasi filenya.';
        _loadingList = false;
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openSurah(int surahNumber) {
    setState(() { _loadingDetail = true; _error = null; });
    try {
      final s = _surahList.firstWhere((s) => s['id'] == surahNumber);
      setState(() { _detail = s; _loadingDetail = false; });
    } catch (e) {
      setState(() { _error = 'Surah tidak ditemukan di data lokal.'; _loadingDetail = false; });
    }
  }

  void _filterSurah(String q) {
    setState(() {
      _filtered = _surahList.where((s) =>
        s['transliteration'].toString().toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  Future<void> _toggleAudio() async {
    if (_detail == null) return;
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(_audioUrlForSurah(_detail!['id'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    final showingDetail = _detail != null || _loadingDetail || (widget.initialSurahNo != null);

    return Scaffold(
      appBar: AppBar(
        title: Text(showingDetail
            ? (_detail?['transliteration'] ?? (widget.isYasinShortcut ? 'Yasin' : 'Memuat...'))
            : "Al-Qur'an"),
        leading: (showingDetail && !widget.isYasinShortcut)
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
                _player.pause();
                setState(() => _detail = null);
              })
            : null,
      ),
      body: showingDetail ? _buildDetail() : _buildList(),
    );
  }

  Widget _buildList() {
    if (_loadingList) return const Center(child: CircularProgressIndicator());
    if (_error != null) return _buildError(_init);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchCtrl,
            onChanged: _filterSurah,
            decoration: InputDecoration(
              hintText: 'Cari Nama Surah...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filtered.length,
            itemBuilder: (context, i) {
              final s = _filtered[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _openSurah(s['id']),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text('${s['id']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(s['transliteration'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${s['total_verses']} AYAT', style: const TextStyle(fontSize: 10, letterSpacing: 1)),
                  trailing: Text(s['name'], style: const TextStyle(fontSize: 22, fontFamily: 'Amiri')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetail() {
    if (_loadingDetail) return const Center(child: CircularProgressIndicator());
    if (_error != null) return _buildError(() => _openSurah(widget.initialSurahNo ?? _detail?['id'] ?? 1));
    if (_detail == null) return const SizedBox();

    final ayatList = _detail!['verses'] as List<dynamic>;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              Text(_detail!['name'], style: const TextStyle(fontFamily: 'Amiri', fontSize: 36, color: Colors.white)),
              const SizedBox(height: 8),
              Text(_detail!['transliteration'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
              const SizedBox(height: 6),
              Text('${_detail!['translation']} • ${_detail!['type'] == 'meccan' ? 'Makkiyah' : 'Madaniyah'}',
                  style: const TextStyle(fontSize: 10, color: Colors.white70, letterSpacing: 1)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                  onPressed: _toggleAudio,
                ),
              ),
              title: const Text('Murotal (Streaming Online)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text('Qori: Mishari Rashid Alafasy', style: TextStyle(fontSize: 10)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: ayatList.length,
            itemBuilder: (context, i) {
              final a = ayatList[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(label: Text('Ayat ${a['id']}', style: const TextStyle(fontSize: 10))),
                      const SizedBox(height: 16),
                      Text(a['text'], textAlign: TextAlign.right,
                          style: const TextStyle(fontFamily: 'Amiri', fontSize: 26, height: 2)),
                      const SizedBox(height: 12),
                      Text(a['translation'], style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildError(VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.folder_off, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(_error ?? 'Terjadi kesalahan', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }
}
