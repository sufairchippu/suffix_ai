import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_color/app_theme.dart';

class ThemeNotifier extends StateNotifier<CupertinoThemeData> {
  ThemeNotifier() : super(const CupertinoThemeData(brightness: Brightness.light));
  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      state = AppTheme.dark;
    } else {
      state = AppTheme.light;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, CupertinoThemeData>((
  ref,
) {
  return ThemeNotifier();
});
