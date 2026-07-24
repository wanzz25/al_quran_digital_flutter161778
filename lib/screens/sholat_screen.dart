import 'package:flutter/material.dart';
import '../data/sholat_data.dart';

class SholatScreen extends StatelessWidget {
  const SholatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bacaan Sholat')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle(title: '5 Waktu Sholat', subtitle: 'Niat & Rakaat'),
          const SizedBox(height: 12),
          ...sholatWaktuData.map((s) => _WaktuCard(item: s)),
          const SizedBox(height: 24),
          const _SectionTitle(title: 'Bacaan Sholat', subtitle: 'Tata Cara Setiap Gerakan'),
          const SizedBox(height: 12),
          ...sholatBacaanData.map((b) => _BacaanCard(item: b)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionTitle({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
        Text(subtitle.toUpperCase(), style: const TextStyle(fontSize: 10, letterSpacing: 2, color: Colors.grey)),
      ],
    );
  }
}

class _WaktuCard extends StatelessWidget {
  final SholatWaktuItem item;
  const _WaktuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ExpansionTile(
        shape: const Border(),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: item.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: Text(item.icon, style: const TextStyle(fontSize: 22))),
        ),
        title: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${item.rakaat} Rakaat • ${item.jenis}', style: const TextStyle(fontSize: 10)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(context, '⏱ Waktu Pelaksanaan'),
                Text(item.waktu, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 12),
                _label(context, '🤲 Niat Sholat'),
                Text(item.niat.arab, textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'Amiri', fontSize: 22, height: 1.8)),
                const SizedBox(height: 6),
                Text(item.niat.latin, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 6),
                Text(item.niat.arti, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1, color: Theme.of(context).colorScheme.primary)),
  );
}

class _BacaanCard extends StatelessWidget {
  final BacaanSholatItem item;
  const _BacaanCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ExpansionTile(
        shape: const Border(),
        title: Text(item.judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.primary)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.arab.isNotEmpty)
                  Text(item.arab, textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'Amiri', fontSize: 22, height: 1.8)),
                if (item.latin.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(item.latin, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Theme.of(context).colorScheme.primary)),
                ],
                if (item.ulang != null) ...[
                  const SizedBox(height: 8),
                  Chip(label: Text(item.ulang!, style: const TextStyle(fontSize: 9)), backgroundColor: Colors.amber.shade50),
                ],
                const SizedBox(height: 8),
                Text(item.arti, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
