import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_color/app_theme.dart';

enum AppThemeMode { system, light, dark }

class ThemeNotifier extends StateNotifier<CupertinoThemeData> {
  AppThemeMode _mode = AppThemeMode.system;
  ThemeNotifier() : super(const CupertinoThemeData());

  void setThemeMode(AppThemeMode mode, {Brightness? systemBrightness}) {
    _mode = mode;
    if (mode == AppThemeMode.dark) {
      state = systemBrightness == Brightness.dark
          ? AppTheme.dark
          : AppTheme.light;
    } else if (mode == AppThemeMode.light) {
      state = AppTheme.light;
    } else {
      state = AppTheme.dark;
    }
  }

  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      state = AppTheme.dark;
    } else {
      state = AppTheme.light;
    }
  }


  void updateSystemTheme(Brightness brightness) {
    if (_mode == AppThemeMode.system) {
      setThemeMode(AppThemeMode.system, systemBrightness: brightness);
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, CupertinoThemeData>((
  ref,
) {
  return ThemeNotifier();
});
