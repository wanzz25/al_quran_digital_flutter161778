import 'package:flutter/material.dart';
import '../data/asma_data.dart';

class AsmaScreen extends StatelessWidget {
  const AsmaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asmaul Husna')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('أسماء الحسنى', style: TextStyle(fontFamily: 'Amiri', fontSize: 30, color: Theme.of(context).colorScheme.primary)),
                const Text('99 NAMA ALLAH', style: TextStyle(fontSize: 10, letterSpacing: 2, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: asmaulHusnaData.length,
              itemBuilder: (context, i) {
                final d = asmaulHusnaData[i];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('#${d.no}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary)),
                        const SizedBox(height: 6),
                        Text(d.arab, style: const TextStyle(fontFamily: 'Amiri', fontSize: 22), textAlign: TextAlign.center),
                        const SizedBox(height: 6),
                        Text(d.latin, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        const SizedBox(height: 2),
                        Text(d.arti, style: const TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
