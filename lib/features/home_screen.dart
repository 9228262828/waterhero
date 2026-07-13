import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../state/app_scope.dart';
import '../theme/app_theme.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _addWater(BuildContext context) async {
    final text = TextEditingController();
    final amount = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          20, 8, 20, 20 + MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: SafeArea(
          top: false,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Add Water',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [150, 250, 350, 500]
                  .map((v) => FilledButton.tonal(
                        onPressed: () => Navigator.pop(sheetContext, v),
                        child: Text('$v ml'),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: text,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Custom amount',
                suffixText: 'ml',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final value = int.tryParse(text.text.trim());
                  if (value != null && value > 0) Navigator.pop(sheetContext, value);
                },
                child: const Text('Add custom amount'),
              ),
            ),
          ]),
        ),
      ),
    );

    if (amount != null && context.mounted) {
      await AppScope.of(context).addWater(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final remaining =
                (controller.settings.dailyGoalMl - controller.todayTotalMl)
                    .clamp(0, controller.settings.dailyGoalMl);
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
              children: [
                Row(children: [
                  const Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('WaterHero',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                      Text('Build a healthier hydration habit.',
                          style: TextStyle(color: AppColors.blue)),
                    ]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ]),
                const SizedBox(height: 28),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: CustomPaint(
                      painter: _ProgressPainter(controller.progress),
                      child: Center(
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('${(controller.progress * 100).round()}%',
                              style: const TextStyle(
                                  fontSize: 44, fontWeight: FontWeight.w900)),
                          Text('${controller.todayTotalMl} / '
                              '${controller.settings.dailyGoalMl} ml'),
                        ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 58,
                  child: FilledButton.icon(
                    onPressed: () => _addWater(context),
                    icon: const Icon(Icons.add),
                    label: Text('Add ${controller.settings.defaultCupMl} ml'),
                  ),
                ),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: _InfoCard(
                    icon: Icons.water_drop_outlined,
                    title: '$remaining ml',
                    subtitle: 'Remaining',
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _InfoCard(
                    icon: Icons.local_fire_department_outlined,
                    title: '${controller.currentStreak} days',
                    subtitle: 'Current streak',
                  )),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _ActionCard(
                    icon: Icons.history_rounded,
                    label: 'Today History',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HistoryScreen()),
                    ),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _ActionCard(
                    icon: Icons.bar_chart_rounded,
                    label: 'Statistics',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const StatisticsScreen()),
                    ),
                  )),
                ]),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addWater(controller.settings.defaultCupMl),
        child: const Icon(Icons.water_drop_rounded),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  const _ProgressPainter(this.progress);
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2 - 14;
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..color = AppColors.blue.withValues(alpha: .12);
    final active = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [AppColors.aqua, AppColors.blue, AppColors.mint],
      ).createShader(rect);
    canvas.drawCircle(center, radius, base);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppColors.blue),
        const SizedBox(height: 18),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        Text(subtitle),
      ]),
    ),
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(children: [
          Icon(icon, color: AppColors.blue),
          const SizedBox(width: 10),
          Expanded(child: Text(label,
              style: const TextStyle(fontWeight: FontWeight.w800))),
        ]),
      ),
    ),
  );
}
