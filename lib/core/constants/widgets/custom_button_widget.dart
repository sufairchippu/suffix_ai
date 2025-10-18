import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/ui_utils.dart';

class CustomButtonWIdget extends StatelessWidget {
  const CustomButtonWIdget({
    super.key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.titile,
    this.boxshadowColor,
    this.onTap,
    this.widget,
    this.padding,
    this.textStyle,
    this.textColor,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.bordercolor,
  });

  final double? height;
  final Color? color;
  final double? borderRadius;
  final String? titile;
  final Color? boxshadowColor;
  final Color? bordercolor;
  final void Function()? onTap;
  final double? padding;
  final Widget? widget;
  final TextStyleType? textStyle;
  final Color? textColor;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          (left ?? 0).rw(context),
          (top ?? 0).rh(context),
          (right ?? 0).rw(context),
          (bottom ?? 0).rh(context),
        ),
        child: Container(
          width: width,
          height: height ?? 49.rh(context),
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: boxshadowColor ?? CupertinoColors.transparent,

                //  topic
                //     ? context.primaryColor.withValues(alpha: .9)
                //     :
                offset: const Offset(0, 2),
                // blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(borderRadius ?? 24.rf(context)),
            border: Border.all(
              color: bordercolor ?? CupertinoColors.transparent,
            ),
          ),

          child: Center(
            child: Padding(
              padding: EdgeInsets.all(padding ?? 8.rf(context)),
              child: Center(
                child:
                    widget ??
                    Uiutils.getTextWidget(
                      context,
                      titile ?? "Topic",
                      textStyle: textStyle,
                      color: textColor ?? context.subTextColor,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
