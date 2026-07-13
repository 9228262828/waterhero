import 'package:flutter/material.dart';
import '../state/app_scope.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _time(DateTime d) {
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    return '$hour:${d.minute.toString().padLeft(2, '0')} '
        '${d.hour >= 12 ? 'PM' : 'AM'}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Today History')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final entries = [...controller.today.entries]
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          if (entries.isEmpty) {
            return const Center(child: Text('No water entries yet today.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final entry = entries[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.water_drop_rounded)),
                  title: Text('${entry.amountMl} ml',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(_time(entry.createdAt)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () => controller.deleteEntry(entry.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
