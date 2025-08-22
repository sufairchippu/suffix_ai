import 'package:flutter/cupertino.dart';

// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors

//! -------------------- Common Colors --------------------

Color kRedColor = const Color(0xFFCC0000);
Color kDarkRedColor = const Color(0xFFC70000);

Color kGreenColor = const Color(0xFF00A86B);
Color kDarkGreenColor = const Color(0xFF17876E);

Color kBlueColor = const Color(0xFF006FC2);
Color kDarkBlueColor = const Color(0xFF00497F);

Color kBlueTwoColor = const Color(0xFF97D3FF);
Color kDarkBlueTwoColor = const Color(0xFF085543);

Color kYellowColor = const Color(0xFFFFD4C200);
Color kDarkYellowColor = const Color(0xFFFFC107);

Color kToggleGreyColor = const Color(0xFF999999);
Color kDarkToggleGreyColor = const Color(0xFFA3A3A3);

Color kGreyFirstColor = const Color(0xFF4B4B4B);
Color kGreySecondColor = const Color(0xFFA3A3A3);

//! -------------------- Light Mode --------------------

Color kLightSecondaryColor = const Color(0xFFF1F7F7);
Color kLightMainDarkShade = const Color(0xFF042222);
Color kLightMainLightShade = const Color(0xFF03624C);

Color kLightPrimaryColor = const Color(0xFF052C49);
Color kLightPrimarySecondColor = const Color(0xFF023B66);

Color kLightTextColor = const Color(0xFF000000);
Color kLightSubTextColor = const Color.fromARGB(255, 162, 160, 160);

Color kLightShimmerBase = const Color(0xFFE1E1E1);
Color kLightShimmerHighlight = const Color(0xFFF5F5F5);

Color kLightContainerGray = const Color(0xFFD6DCE1);
Color kLightCardColor = const Color(0xFFFFFFFF);
Color kLightBorderColor = const Color(0xFFF0F0F0);
Color kLightScaffoldColor = const Color(0xFFFFFFFF);

Color kLightExpensesShadowColor = const Color.fromRGBO(0, 0, 0, 0.08);

Color kLightcolor1 = const Color(0xFF92FE9D);
Color kLightcolor2 = const Color(0xFF00C9FF);
Color kLightcolor3 = const Color(0xFFE0F7FA);
//! -------------------- Dark Mode --------------------

Color kDarkSecondaryColor = const Color(0xFF0B1014);
Color kDarkMainDarkShade = const Color(0xFF085543);
Color kDarkMainLightShade = const Color(0xFF17876E);

Color kDarkPrimaryColor = const Color(0xFF00497F);
Color kDarkPrimarySecondColor = const Color(0xFF242426);

Color kDarkTextColor = const Color(0xFFFFFFFF);
Color kDarkSubTextColor = const Color.fromARGB(255, 187, 184, 184);

Color kDarkShimmerBase = const Color(0xFF363535);
Color kDarkShimmerHighlight = const Color(0xFF3B3B3B);

Color kDarkContainerGray = const Color(0xFF28282B);
Color kDarkCardColor = const Color(0xFF030C0F);
Color kDarkBorderColor = const Color(0xFF3B3C3F);
Color kDarkScaffoldColor = const Color(0xFF282727);

Color kDarkcolor1 = const Color(0xFF0F2027);
Color kDarkcolor2 = const Color(0xFF203A43);
Color kDarkcolor3 = const Color(0xFF2C5364);

Color kDarkExpensesShadowColor = const Color.fromRGBO(0, 0, 0, 0.4);

class AppColors {
  // ---- Base Colors ----
  static CupertinoDynamicColor red = CupertinoDynamicColor.withBrightness(
    color: kRedColor,
    darkColor: kDarkRedColor,
  );

  static CupertinoDynamicColor green = CupertinoDynamicColor.withBrightness(
    color: kGreenColor,
    darkColor: kDarkGreenColor,
  );

  static CupertinoDynamicColor blue = CupertinoDynamicColor.withBrightness(
    color: kBlueColor,
    darkColor: kDarkBlueColor,
  );

  static CupertinoDynamicColor blueTwo = CupertinoDynamicColor.withBrightness(
    color: kBlueTwoColor,
    darkColor: kDarkBlueColor,
  );

  static CupertinoDynamicColor yellow = CupertinoDynamicColor.withBrightness(
    color: kYellowColor,
    darkColor: kDarkYellowColor,
  );

  static CupertinoDynamicColor toggleGrey =
      CupertinoDynamicColor.withBrightness(
        color: kToggleGreyColor,
        darkColor: kDarkToggleGreyColor,
      );

  static CupertinoDynamicColor greyFirst = CupertinoDynamicColor.withBrightness(
    color: kGreyFirstColor,
    darkColor: kGreyFirstColor,
  );

  static CupertinoDynamicColor greySecond =
      CupertinoDynamicColor.withBrightness(
        color: kGreySecondColor,
        darkColor: kGreySecondColor,
      );

  // ---- Light vs Dark ----
  static CupertinoDynamicColor secondary = CupertinoDynamicColor.withBrightness(
    color: kLightSecondaryColor,
    darkColor: kDarkSecondaryColor,
  );

  static CupertinoDynamicColor mainDarkShade =
      CupertinoDynamicColor.withBrightness(
        color: kLightMainDarkShade,
        darkColor: kDarkMainDarkShade,
      );

  static CupertinoDynamicColor mainLightShade =
      CupertinoDynamicColor.withBrightness(
        color: kLightMainLightShade,
        darkColor: kDarkMainLightShade,
      );

  static CupertinoDynamicColor primary = CupertinoDynamicColor.withBrightness(
    color: kLightPrimaryColor,
    darkColor: kDarkPrimaryColor,
  );

  static CupertinoDynamicColor primarySecond =
      CupertinoDynamicColor.withBrightness(
        color: kLightPrimarySecondColor,
        darkColor: kDarkPrimarySecondColor,
      );

  // ---- Text ----
  static CupertinoDynamicColor text = CupertinoDynamicColor.withBrightness(
    color: kLightTextColor,
    darkColor: kDarkTextColor,
  );

  static CupertinoDynamicColor subText = CupertinoDynamicColor.withBrightness(
    color: kLightSubTextColor,
    darkColor: kDarkSubTextColor,
  );

  // ---- Shimmer ----
  static CupertinoDynamicColor shimmerBase =
      CupertinoDynamicColor.withBrightness(
        color: kLightShimmerBase,
        darkColor: kDarkShimmerBase,
      );

  static CupertinoDynamicColor shimmerHighlight =
      CupertinoDynamicColor.withBrightness(
        color: kLightShimmerHighlight,
        darkColor: kDarkShimmerHighlight,
      );

  // ---- UI Elements ----
  static CupertinoDynamicColor containerGray =
      CupertinoDynamicColor.withBrightness(
        color: kLightContainerGray,
        darkColor: kDarkContainerGray,
      );

  static CupertinoDynamicColor card = CupertinoDynamicColor.withBrightness(
    color: kLightCardColor,
    darkColor: kDarkCardColor,
  );
  static CupertinoDynamicColor card2 = CupertinoDynamicColor.withBrightness(
    color: greySecond,
    darkColor: kDarkSubTextColor,
  );

  static CupertinoDynamicColor border = CupertinoDynamicColor.withBrightness(
    color: kLightBorderColor,
    darkColor: kDarkBorderColor,
  );

  static CupertinoDynamicColor scaffold = CupertinoDynamicColor.withBrightness(
    color: kLightScaffoldColor,
    darkColor: kDarkScaffoldColor,
  );

  // ---- Shadows ----
  static CupertinoDynamicColor expensesShadow =
      CupertinoDynamicColor.withBrightness(
        color: kLightExpensesShadowColor,
        darkColor: kDarkExpensesShadowColor,
      );
  // CupertinoDynamicColor equivalents
  static CupertinoDynamicColor dynamicColor1 =
      CupertinoDynamicColor.withBrightness(
        color: kLightcolor1, // Light mode
        darkColor: kDarkcolor1, // Dark mode
      );

  static CupertinoDynamicColor dynamicColor2 =
      CupertinoDynamicColor.withBrightness(
        color: kLightcolor2,
        darkColor: kDarkcolor2,
      );

  static CupertinoDynamicColor dynamicColor3 =
      CupertinoDynamicColor.withBrightness(
        color: kLightcolor3,
        darkColor: kDarkcolor3,
      );
       static CupertinoDynamicColor dynamicColor4 =
      CupertinoDynamicColor.withBrightness(
        color: kLightcolor3,
        darkColor: kDarkCardColor,
      );
  static CupertinoDynamicColor buttnColor =
      CupertinoDynamicColor.withBrightness(
        color: kLightcolor1,
        darkColor: kLightcolor3,
      );
}
