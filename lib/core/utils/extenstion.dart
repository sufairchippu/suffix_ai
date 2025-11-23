import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:flutter/cupertino.dart';


extension StringCapitalization on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}



extension ContextMeasurements on BuildContext {
  double get appPadding => 12.rw(this);
  double get cBorderRadius => 10.rf(this);
  double get cWidgetSpace => 10.rh(this);
  double get cWidgetHeadingSpace => 5.rh(this);
  double get cBorderRadius50 => 50.rf(this);
  double get verticalPadding => 10.rh(this);
  double get horizontalPadding => 10.rw(this);
  double get verticalMargin => 10.rh(this);
  double get horizontalMargin => 10.rw(this);
  double get verticalPadding20 => 20.rh(this);
  double get verticalPadding30 => 30.rh(this);
  double get verticalPadding40 => 40.rh(this);
  double get verticalPadding45 => 45.rh(this);
  double get horizontalPadding24 => 24.rw(this);
  double get horizontalPadding50 => 50.rw(this);
  double get horizontalPadding20 => 20.rw(this);
}

extension DateTimeFormatting on DateTime {
  /// Format as dd/MM/yyyy HH:mm:ss
  String toFormattedString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final d = twoDigits(day);
    final m = twoDigits(month);
    final y = year.toString();

    final h = twoDigits(hour);
    final min = twoDigits(minute);
    final s = twoDigits(second);

    return "$d/$m/$y $h:$min:$s";
  }
}
