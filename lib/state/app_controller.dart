import 'package:flutter/material.dart';
import '../data/local_storage.dart';
import '../data/models.dart';

class AppController extends ChangeNotifier {
  AppController(this._storage);
  final LocalStorage _storage;

  AppSettings _settings = AppSettings.defaults();
  List<DailyRecord> _records = [];

  AppSettings get settings => _settings;
  List<DailyRecord> get records => List.unmodifiable(_records);

  Future<void> load() async {
    _settings = _storage.loadSettings();
    _records = _storage.loadRecords();
    _ensureToday();
    notifyListeners();
  }

  DailyRecord get today {
    _ensureToday();
    final key = dateKey(DateTime.now());
    return _records.firstWhere((e) => e.date == key);
  }

  int get todayTotalMl => today.totalMl;
  double get progress =>
      (_settings.dailyGoalMl == 0 ? 0 : todayTotalMl / _settings.dailyGoalMl)
          .clamp(0.0, 1.0);

  int get currentStreak {
    var streak = 0;
    var cursor = DateTime.now();
    if (!_recordFor(cursor).completed) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    while (_recordFor(cursor).completed) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int get bestStreak {
    final sorted = [..._records]..sort((a, b) => a.date.compareTo(b.date));
    var best = 0;
    var current = 0;
    DateTime? previous;

    for (final record in sorted) {
      if (!record.completed) {
        current = 0;
        previous = null;
        continue;
      }
      final parts = record.date.split('-').map(int.parse).toList();
      final date = DateTime(parts[0], parts[1], parts[2]);
      current = previous != null && date.difference(previous).inDays == 1
          ? current + 1
          : 1;
      if (current > best) best = current;
      previous = date;
    }
    return best;
  }

  List<DailyRecord> get lastSevenDays => List.generate(7, (index) {
    final date = DateTime.now().subtract(Duration(days: 6 - index));
    return _recordFor(date);
  });

  DailyRecord _recordFor(DateTime date) {
    final key = dateKey(date);
    for (final record in _records) {
      if (record.date == key) return record;
    }
    return DailyRecord(date: key, goalMl: _settings.dailyGoalMl, entries: const []);
  }

  void _ensureToday({bool updateGoal = false}) {
    final key = dateKey(DateTime.now());
    final index = _records.indexWhere((e) => e.date == key);
    if (index == -1) {
      _records = [
        ..._records,
        DailyRecord(date: key, goalMl: _settings.dailyGoalMl, entries: const []),
      ];
    } else if (updateGoal) {
      final copy = [..._records];
      copy[index] = copy[index].copyWith(goalMl: _settings.dailyGoalMl);
      _records = copy;
    }
  }

  Future<void> completeOnboarding(int goal, int cup) async {
    _settings = _settings.copyWith(
      dailyGoalMl: goal,
      defaultCupMl: cup,
      onboardingCompleted: true,
    );
    _ensureToday(updateGoal: true);
    await _saveAll();
  }

  Future<void> addWater(int amount) async {
    if (amount <= 0) return;
    _ensureToday();
    final key = dateKey(DateTime.now());
    final entry = WaterEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      amountMl: amount,
      createdAt: DateTime.now(),
    );
    _records = _records.map((record) {
      if (record.date != key) return record;
      return record.copyWith(entries: [...record.entries, entry]);
    }).toList();
    await _saveRecords();
  }

  Future<void> deleteEntry(String id) async {
    final key = dateKey(DateTime.now());
    _records = _records.map((record) {
      if (record.date != key) return record;
      return record.copyWith(
        entries: record.entries.where((e) => e.id != id).toList(),
      );
    }).toList();
    await _saveRecords();
  }

  Future<void> resetToday() async {
    final key = dateKey(DateTime.now());
    _records = _records.map((record) {
      if (record.date != key) return record;
      return record.copyWith(entries: const []);
    }).toList();
    await _saveRecords();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _settings = _settings.copyWith(themeMode: mode);
    await _saveSettings();
  }

  Future<void> setDailyGoal(int value) async {
    _settings = _settings.copyWith(dailyGoalMl: value);
    _ensureToday(updateGoal: true);
    await _saveAll();
  }

  Future<void> setDefaultCup(int value) async {
    _settings = _settings.copyWith(defaultCupMl: value);
    await _saveSettings();
  }

  Future<void> clearAllData() async {
    await _storage.clearAll();
    _settings = AppSettings.defaults();
    _records = [];
    _ensureToday();
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    await _storage.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> _saveRecords() async {
    await _storage.saveRecords(_records);
    notifyListeners();
  }

  Future<void> _saveAll() async {
    await _storage.saveSettings(_settings);
    await _storage.saveRecords(_records);
    notifyListeners();
  }
}
