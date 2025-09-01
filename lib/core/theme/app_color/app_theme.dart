import 'package:flutter/cupertino.dart';

import 'app_color.dart';

class AppTheme {
  static final light = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.buttnColor,
    scaffoldBackgroundColor: AppColors.scaffold,
    barBackgroundColor: AppColors.blue,
    textTheme: CupertinoTextThemeData(primaryColor: AppColors.text),
  );

  static final dark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.buttnColor,
    scaffoldBackgroundColor: AppColors.card ,
    barBackgroundColor: AppColors.blue,
    textTheme: CupertinoTextThemeData(primaryColor: AppColors.text),
    applyThemeToAll: true,
  );
}
