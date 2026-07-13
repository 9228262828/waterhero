import 'package:flutter/material.dart';

String dateKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.dailyGoalMl,
    required this.defaultCupMl,
    required this.onboardingCompleted,
  });

  final ThemeMode themeMode;
  final int dailyGoalMl;
  final int defaultCupMl;
  final bool onboardingCompleted;

  factory AppSettings.defaults() => const AppSettings(
    themeMode: ThemeMode.system,
    dailyGoalMl: 2500,
    defaultCupMl: 250,
    onboardingCompleted: false,
  );

  AppSettings copyWith({
    ThemeMode? themeMode,
    int? dailyGoalMl,
    int? defaultCupMl,
    bool? onboardingCompleted,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    dailyGoalMl: dailyGoalMl ?? this.dailyGoalMl,
    defaultCupMl: defaultCupMl ?? this.defaultCupMl,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
  );

  Map<String, dynamic> toJson() => {
    'themeMode': themeMode.name,
    'dailyGoalMl': dailyGoalMl,
    'defaultCupMl': defaultCupMl,
    'onboardingCompleted': onboardingCompleted,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final name = json['themeMode'] as String? ?? 'system';
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == name,
        orElse: () => ThemeMode.system,
      ),
      dailyGoalMl: json['dailyGoalMl'] as int? ?? 2500,
      defaultCupMl: json['defaultCupMl'] as int? ?? 250,
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
    );
  }
}

class WaterEntry {
  const WaterEntry({
    required this.id,
    required this.amountMl,
    required this.createdAt,
  });

  final String id;
  final int amountMl;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'amountMl': amountMl,
    'createdAt': createdAt.toIso8601String(),
  };

  factory WaterEntry.fromJson(Map<String, dynamic> json) => WaterEntry(
    id: json['id'] as String,
    amountMl: json['amountMl'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

class DailyRecord {
  const DailyRecord({
    required this.date,
    required this.goalMl,
    required this.entries,
  });

  final String date;
  final int goalMl;
  final List<WaterEntry> entries;

  int get totalMl => entries.fold(0, (sum, e) => sum + e.amountMl);
  bool get completed => totalMl >= goalMl;

  DailyRecord copyWith({
    int? goalMl,
    List<WaterEntry>? entries,
  }) => DailyRecord(
    date: date,
    goalMl: goalMl ?? this.goalMl,
    entries: entries ?? this.entries,
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'goalMl': goalMl,
    'entries': entries.map((e) => e.toJson()).toList(),
  };

  factory DailyRecord.fromJson(Map<String, dynamic> json) => DailyRecord(
    date: json['date'] as String,
    goalMl: json['goalMl'] as int,
    entries: (json['entries'] as List<dynamic>? ?? [])
        .map((e) => WaterEntry.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}
