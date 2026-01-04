import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/roadmap/domain/models/user_progress.dart';

class LocalDataSource {
  static const String _keyUserProgress = 'user_progress_v1';

  Future<void> saveProgress(UserProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(progress.toJson());
    await prefs.setString(_keyUserProgress, jsonString);
  }

  Future<UserProgress> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserProgress);

    if (jsonString == null) {
      return const UserProgress();
    }

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProgress.fromJson(jsonMap);
    } catch (e) {
      return const UserProgress();
    }
  }
}
