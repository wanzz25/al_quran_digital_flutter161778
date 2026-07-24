import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/zikir_data.dart';

class ZikirScreen extends StatefulWidget {
  const ZikirScreen({super.key});
  @override
  State<ZikirScreen> createState() => _ZikirScreenState();
}

class _ZikirScreenState extends State<ZikirScreen> {
  late List<int> counts;

  @override
  void initState() {
    super.initState();
    counts = List.filled(zikirData.length, 0);
  }

  void _tap(int i) {
    setState(() => counts[i]++);
    HapticFeedback.lightImpact();
    if (counts[i] == zikirData[i].target) HapticFeedback.mediumImpact();
  }

  void _reset(int i) {
    setState(() => counts[i] = 0);
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Zikir Ba'da Sholat")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: zikirData.length,
        itemBuilder: (context, i) {
          final z = zikirData[i];
          final done = counts[i] >= z.target;
          final progress = (counts[i] / z.target).clamp(0.0, 1.0);
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(z.judul, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  const SizedBox(height: 12),
                  Text(z.arab, style: const TextStyle(fontFamily: 'Amiri', fontSize: 26, height: 1.6)),
                  const SizedBox(height: 8),
                  Text(z.latin, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 4),
                  Text(z.arti, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 64, height: 64,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 4,
                              backgroundColor: Colors.grey.shade200,
                              color: done ? Colors.amber : Theme.of(context).colorScheme.primary,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${counts[i]}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('/${z.target}', style: const TextStyle(fontSize: 8, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton.filledTonal(onPressed: () => _reset(i), icon: const Icon(Icons.refresh)),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () => _tap(i),
                        style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
                        child: const Text('TAP', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
