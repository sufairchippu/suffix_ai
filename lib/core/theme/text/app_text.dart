import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextStyleType {
  heading,
  subHeading,
  largeBold,
  //10
  extraSmallRegular,
  extraSmallsemiBold,
  extraSmallBold,
  //12 w400
  smallRegular,
  smallSemiBold,
  smallBold,
  //12 bold
  mediumRegular,
  mediumSemiBold,
  mediumBold,
  errorText,
}

class AppText {
  static TextStyle getStyle(
    BuildContext context,
    TextStyleType type, {
    Color? color,
    FontWeight? fontweight,
    double? fontSize,
  }) {
    final defaultzColor = color ?? context.greySecondColor;

    TextStyle buildStyle({
      required double size,
      required FontWeight fw,
      required Color clr,
    }) {
      return GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: fw,
          fontSize: size.rf(context),
          color: clr,
        ),
      );
    }

    switch (type) {
      case TextStyleType.heading:
        return buildStyle(
          size: fontSize ?? 24.rf(context),
          fw: fontweight ?? FontWeight.bold,
          clr: defaultzColor,
        );

      case TextStyleType.subHeading:
        return buildStyle(
          size: fontSize ?? 18.rf(context),
          fw: fontweight ?? FontWeight.w600,
          clr: defaultzColor,
        );

      case TextStyleType.largeBold:
        return buildStyle(
          size: fontSize ?? 18.rf(context),
          fw: fontweight ?? FontWeight.bold,
          clr: defaultzColor,
        );

      case TextStyleType.extraSmallRegular:
        return buildStyle(
          size: fontSize ?? 10.rf(context),
          fw: fontweight ?? FontWeight.w400,
          clr: defaultzColor,
        );

      case TextStyleType.extraSmallsemiBold:
        return buildStyle(
          size: fontSize ?? 8.rf(context),
          fw: fontweight ?? FontWeight.w600,
          clr: defaultzColor,
        );

      case TextStyleType.extraSmallBold:
        return buildStyle(
          size: fontSize ?? 10.rf(context),
          fw: fontweight ?? FontWeight.bold,
          clr: defaultzColor,
        );

      case TextStyleType.smallRegular:
        return buildStyle(
          size: fontSize ?? 12.rf(context),
          fw: fontweight ?? FontWeight.w400,
          clr: defaultzColor,
        );

      case TextStyleType.smallSemiBold:
        return buildStyle(
          size: fontSize ?? 12.rf(context),
          fw: fontweight ?? FontWeight.w600,
          clr: defaultzColor,
        );

      case TextStyleType.smallBold:
        return buildStyle(
          size: fontSize ?? 12.rf(context),
          fw: fontweight ?? FontWeight.bold,
          clr: defaultzColor,
        );

      case TextStyleType.mediumRegular:
        return buildStyle(
          size: fontSize ?? 14.rf(context),
          fw: fontweight ?? FontWeight.w400,
          clr: context.cardColor2, // defaultzColor,
        );

      case TextStyleType.mediumSemiBold:
        return buildStyle(
          size: fontSize ?? 14.rf(context),
          fw: fontweight ?? FontWeight.w600,
          clr: defaultzColor,
        );

      case TextStyleType.mediumBold:
        return buildStyle(
          size: fontSize ?? 14.rf(context),
          fw: fontweight ?? FontWeight.bold,
          clr: defaultzColor,
        );

      case TextStyleType.errorText:
        return buildStyle(
          size: fontSize ?? 12.rf(context),
          fw: fontweight ?? FontWeight.w500,
          clr: CupertinoColors.destructiveRed,
        );
    }
  }
}
