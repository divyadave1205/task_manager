import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() async {
    final box = await Hive.openBox('preferences');
    final isDarkMode = box.get('isDarkMode', defaultValue: false);
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() async {
    final box = await Hive.openBox('preferences');
    final isDarkMode = state == ThemeMode.dark;
    box.put('isDarkMode', !isDarkMode);
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
}
