import 'package:flutter/cupertino.dart';

import 'app_color.dart';

extension CupertinoColorExtension on BuildContext {
  // Base
  Color get red => AppColors.red.resolveFrom(this);
  Color get green => AppColors.green.resolveFrom(this);
  Color get blue => AppColors.blue.resolveFrom(this);
  Color get blueTwo => AppColors.blueTwo.resolveFrom(this);
  Color get yellow => AppColors.yellow.resolveFrom(this);
  Color get toggleGrey => AppColors.toggleGrey.resolveFrom(this);

  // Theme aware
  Color get secondaryColor => AppColors.secondary.resolveFrom(this);
  Color get mainDarkShadeColor => AppColors.mainDarkShade.resolveFrom(this);
  Color get mainLightShadeColor => AppColors.mainLightShade.resolveFrom(this);
  Color get primaryColor => AppColors.primary.resolveFrom(this);
  Color get primarySecondColor => AppColors.primarySecond.resolveFrom(this);

  Color get textColor => AppColors.text.resolveFrom(this);
  Color get subTextColor => AppColors.subText.resolveFrom(this);
  Color get shimmerBaseColor => AppColors.shimmerBase.resolveFrom(this);
  Color get shimmerHighlightColor =>
      AppColors.shimmerHighlight.resolveFrom(this);

  Color get containerGrayColor => AppColors.containerGray.resolveFrom(this);
  Color get cardColor => AppColors.card.resolveFrom(this);
  Color get cardColor2 => AppColors.card2.resolveFrom(this);

  Color get borderColor => AppColors.border.resolveFrom(this);
  Color get scaffoldColor => AppColors.scaffold.resolveFrom(this);
  Color get expensesShadowColor => AppColors.expensesShadow.resolveFrom(this);

  Color get greyFirstColor => AppColors.greyFirst.resolveFrom(this);
  Color get greySecondColor => AppColors.greySecond.resolveFrom(this);

  Color get dynamicColor1 => AppColors.dynamicColor1.resolveFrom(this);
  Color get dynamicColor2 => AppColors.dynamicColor2.resolveFrom(this);
  Color get dynamicColor3 => AppColors.dynamicColor3.resolveFrom(this);
  Color get dynamicColor4 => AppColors.dynamicColor4.resolveFrom(this);

  Color get buttnColor => AppColors.buttnColor.resolveFrom(this);

}
