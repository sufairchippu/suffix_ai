import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/ui_utils.dart';
import '../app_constants.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.logoNeeded = true,
    this.logoheit = 35,
    this.textSize = 18,
    this.textStyle,
    this.textColor,
    this.textcolor2,
  });
  final bool logoNeeded;
  final double logoheit;
  final double textSize;
  final TextStyleType? textStyle;
  final Color? textColor;
  final Color? textcolor2;

  @override
  Widget build(BuildContext context) {
    return Row(
      // spacing: 5.rw(context),
      children: [
        logoNeeded
            ? Uiutils.getassetImage(
                ImageConstants.logo,
                height: logoheit,
                width: logoheit / 7 * 6,
              )
            : SizedBox(height: 0, width: 0),
        Uiutils.getTextWidget(
          context,
          AppConstants.appName,
          color: textColor ?? context.greyFirstColor,
          fs: textSize,
          textStyle: textStyle ?? TextStyleType.heading,
        ),
        SizedBox(width: 3.rw(context)),
        Uiutils.getTextWidget(
          context,
          'AI',
          color: textcolor2 ?? context.greySecondColor,
          textStyle: textStyle ?? TextStyleType.heading,
          fs: textSize / 7 * 8, //change here accordinggllyyy
        ),
      ],
    );
  }
}
