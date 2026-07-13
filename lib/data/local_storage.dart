import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class LocalStorage {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  AppSettings loadSettings() {
    final raw = _prefs.getString('waterhero_settings');
    if (raw == null) return AppSettings.defaults();
    try {
      return AppSettings.fromJson(
        Map<String, dynamic>.from(jsonDecode(raw) as Map),
      );
    } catch (_) {
      return AppSettings.defaults();
    }
  }

  List<DailyRecord> loadRecords() {
    final raw = _prefs.getString('waterhero_daily_records');
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>)
          .map((e) => DailyRecord.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveSettings(AppSettings value) =>
      _prefs.setString('waterhero_settings', jsonEncode(value.toJson()));

  Future<void> saveRecords(List<DailyRecord> value) =>
      _prefs.setString(
        'waterhero_daily_records',
        jsonEncode(value.map((e) => e.toJson()).toList()),
      );

  Future<void> clearAll() async {
    await _prefs.remove('waterhero_settings');
    await _prefs.remove('waterhero_daily_records');
  }
}
