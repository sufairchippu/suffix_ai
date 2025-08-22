import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class Uiutils {
  static LottieBuilder getLottie(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
    bool? repeat,
  }) {
    return Lottie.asset(
      assetName,
      fit: boxfit,
      height: height,
      width: width,
      repeat: repeat,
    );
  }

  static SvgPicture getSvg(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return SvgPicture.asset(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
    );
  }

  static Image getassetImage(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return Image.asset(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
    );
  }

  static Image getNetworkImage(
    String assetName, {

    double? height,
    double? width,
    BoxFit? boxfit,
  }) {
    return Image.network(
      assetName,
      fit: boxfit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 60,
    );
  }

  static Text getTextWidget(
    BuildContext context,
    String title, {
    int? maxline,
    TextOverflow? overFlow,
    Color? color,
    double? fs,
    FontWeight? fw,
    TextStyleType? textStyle,
  }) {
    return Text(
      title,
      style: AppText.getStyle(
        color: color,
        fontSize: fs,
        fontweight: fw,
        context,
        textStyle ?? TextStyleType.mediumRegular,
      ),
      maxLines: maxline ?? 5,
      overflow: overFlow ?? TextOverflow.ellipsis,
    );
  }

  static DateTime parseBackendDate(String dateString) {
    final parts = dateString.split(' ');
    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[2]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[0]), // day
      int.parse(timeParts[0]), // hour
      int.parse(timeParts[1]), // minute
      int.parse(timeParts[2]), // second
    );
  }
  static String timeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return "Just Now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} min ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hrs ago";
  } else if (difference.inDays == 1) {
    return "Yesterday";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} days ago";
  } else {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
}
