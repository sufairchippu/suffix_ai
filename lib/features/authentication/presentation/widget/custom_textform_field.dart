import 'dart:ui';

import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/ui_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.icon,
    this.text,
    this.hintText,
    this.onTap,
    this.isWantsuffix = false,
    required this.obscure,
    this.validator,
    this.iconSize,
    this.iconColor,
    this.suffixIcon,
    this.prefixOntap,
    this.textInputAction,
    this.fillcolor,
    this.boxshadows,
    this.loadingOnsomething = false,
    this.prefixNeeded = true,
    this.maxline,
    this.onHold,
  });
  final double? iconSize;
  final TextEditingController? controller;
  final String? text;
  final IconData? icon;
  final String? hintText;
  final VoidCallback? onTap;
  final VoidCallback? prefixOntap;
  final bool isWantsuffix;
  final bool obscure;
  final String? Function(String?)? validator;
  final Color? iconColor;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;
  final Color? fillcolor;
  final List<BoxShadow>? boxshadows;
  final bool loadingOnsomething;
  final int? maxline;
  final void Function()? onHold;
  final bool prefixNeeded;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Uiutils.getTextWidget(context, text ?? ''),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: boxshadows,
                color: fillcolor ?? CupertinoColors.transparent,
                borderRadius: BorderRadius.circular(18.rf(context)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: isWantsuffix
                      ? 45.rw(context)
                      : 8.rw(context), // Extra space for suffix icon
                ),
                child: CupertinoTextFormFieldRow(
                  maxLines: maxline,
                  readOnly: loadingOnsomething,
                  keyboardAppearance: Brightness.dark,
                  textInputAction: textInputAction ?? TextInputAction.send,
                  selectionHeightStyle: BoxHeightStyle.max,
                  prefix: prefixNeeded
                      ? Padding(
                          padding: EdgeInsets.only(
                            right: 10.rf(context),
                            left: 10.rw(context),
                          ),
                          child: GestureDetector(
                            onTap: prefixOntap,
                            child: Icon(
                              icon ?? CupertinoIcons.mail_solid,
                              size: iconSize,
                              color: iconColor,
                            ),
                          ),
                        )
                      : null,
                  padding: EdgeInsets.symmetric(vertical: 15.rh(context)),
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: obscure,
                  placeholder: hintText ?? '',
                  placeholderStyle: AppText.getStyle(
                    context,
                    TextStyleType.mediumRegular,
                    color: loadingOnsomething
                        ? context.cardColor2.withValues(alpha: .6)
                        : null,
                  ),
                  validator: validator,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: context.cardColor2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            if (isWantsuffix)
              GestureDetector(
                onLongPress: onHold,
                onTap: loadingOnsomething ? null : onTap,
                child: Padding(
                  padding: EdgeInsets.all(15.rf(context)),
                  child: Icon(
                    suffixIcon ??
                        (obscure
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye),
                    color: iconColor,
                    size: 24.rf(context),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
