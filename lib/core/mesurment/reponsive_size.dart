import 'package:flutter/cupertino.dart';

class AppDimensions {
  static const double baseHeight = 850;
  static const double baseWidth = 450;
  static const double baseLandscapeHeight = 750;
  static const double baseLandscapeWidth = 800;
}

extension Sizing on num {
  double rh(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final double baseHeight = orientation == Orientation.portrait
        ? AppDimensions.baseHeight
        : AppDimensions.baseLandscapeHeight;
    return (this / baseHeight) * mediaQuery.size.height;
  }

  double rw(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final double baseWidth = orientation == Orientation.portrait
        ? AppDimensions.baseWidth
        : AppDimensions.baseLandscapeWidth;
    return (this / baseWidth) * mediaQuery.size.width;
  }

  double rf(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final double baseHeight = orientation == Orientation.portrait
        ? AppDimensions.baseHeight
        : AppDimensions.baseLandscapeHeight;
    return mediaQuery.textScaler.scale(
      (this / baseHeight) * mediaQuery.size.height,
    );
  }
}

class OrientationUtils {
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 600;
}
