import 'package:flutter/material.dart';
import '../state/app_scope.dart';
import '../theme/app_theme.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final days = controller.lastSevenDays;
          final total = days.fold(0, (sum, d) => sum + d.totalMl);
          final completed = days.where((d) => d.completed).length;
          final average = (total / 7).round();

          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Text('Last 7 days',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: SizedBox(
                    height: 220,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: days.map((day) {
                        final ratio = day.goalMl == 0
                            ? 0.0
                            : (day.totalMl / day.goalMl).clamp(0.0, 1.0);
                        final weekday = DateTime.parse(day.date).weekday;
                        const labels = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FractionallySizedBox(
                                      heightFactor: ratio == 0 ? .03 : ratio,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [AppColors.aqua, AppColors.blue],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(labels[weekday - 1],
                                    style: const TextStyle(fontSize: 11)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              _Row('Daily average', '$average ml'),
              _Row('Completed days', '$completed / 7'),
              _Row('Current streak', '${controller.currentStreak} days'),
              _Row('Best streak', '${controller.bestStreak} days'),
            ],
          );
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(top: 10),
    child: ListTile(
      title: Text(label),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
    ),
  );
}
