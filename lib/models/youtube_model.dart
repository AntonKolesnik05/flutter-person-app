import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeModel extends ChangeNotifier {
  final Set<String> subscribedChannels = {};

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  String _asyncMessage = 'Натисни кнопку для демонстрації асинхронності';
  String get asyncMessage => _asyncMessage;

  YoutubeModel() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);

    notifyListeners();
  }

  void subscribe(String channelId) {
    subscribedChannels.add(channelId);
    notifyListeners();
  }

  bool isSubscribed(String channelId) {
    return subscribedChannels.contains(channelId);
  }

  int get subscriptionsCount => subscribedChannels.length;

  void demoAsyncWithThen() {
    _asyncMessage = 'Запуск async через .then()...';
    notifyListeners();

    Future.delayed(const Duration(seconds: 2))
        .then((_) => SharedPreferences.getInstance())
        .then((prefs) {
          final savedTheme = prefs.getBool('isDarkTheme') ?? false;

          _asyncMessage =
              '.then(): Future виконано. Збережена тема = ${savedTheme ? "темна" : "світла"}';
          notifyListeners();
        })
        .catchError((error) {
          _asyncMessage = '.then(): Помилка -> $error';
          notifyListeners();
        });
  }

  Future<void> demoAsyncWithAwait() async {
    try {
      _asyncMessage = 'Запуск async через await...';
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();

      final savedTheme = prefs.getBool('isDarkTheme') ?? false;
      _asyncMessage =
          'await: Future виконано. Збережена тема = ${savedTheme ? "темна" : "світла"}';
      notifyListeners();
    } catch (error) {
      _asyncMessage = 'await: Помилка -> $error';
      notifyListeners();
    }
  }
}