import 'package:flutter/material.dart';
import '../state/app_scope.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _page = 0;
  int _goal = 2500;
  int _cup = 250;

  Future<void> _finish() async {
    await AppScope.of(context).completeOnboarding(_goal, _cup);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _Intro(
        icon: Icons.water_drop_rounded,
        title: 'Stay Hydrated',
        text: 'Track your daily water intake in seconds.',
      ),
      const _Intro(
        icon: Icons.local_fire_department_rounded,
        title: 'Build Your Streak',
        text: 'Reach your daily goal and keep your habit growing.',
      ),
      _Setup(
        goal: _goal,
        cup: _cup,
        onGoal: (v) => setState(() => _goal = v),
        onCup: (v) => setState(() => _cup = v),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (v) => setState(() => _page = v),
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(4),
                  width: _page == i ? 28 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _page == i
                        ? AppColors.blue
                        : AppColors.blue.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_page == pages.length - 1) {
                      _finish();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: Text(_page == pages.length - 1 ? 'Start tracking' : 'Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [AppColors.aqua, AppColors.blue]),
            ),
            child: Icon(icon, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 34),
          Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Setup extends StatelessWidget {
  const _Setup({
    required this.goal,
    required this.cup,
    required this.onGoal,
    required this.onCup,
  });
  final int goal;
  final int cup;
  final ValueChanged<int> onGoal;
  final ValueChanged<int> onCup;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(28),
      children: [
        const SizedBox(height: 40),
        const Text('Set your hydration plan',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        const SizedBox(height: 28),
        _SliderCard(
          title: 'Daily goal',
          value: '$goal ml',
          slider: Slider(
            min: 1000,
            max: 5000,
            divisions: 16,
            value: goal.toDouble(),
            onChanged: (v) => onGoal(v.round()),
          ),
        ),
        _SliderCard(
          title: 'Default cup',
          value: '$cup ml',
          slider: Slider(
            min: 100,
            max: 500,
            divisions: 8,
            value: cup.toDouble(),
            onChanged: (v) => onCup(v.round()),
          ),
        ),
      ],
    );
  }
}

class _SliderCard extends StatelessWidget {
  const _SliderCard({required this.title, required this.value, required this.slider});
  final String title;
  final String value;
  final Widget slider;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          Row(children: [
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
            Text(value),
          ]),
          slider,
        ]),
      ),
    );
  }
}
