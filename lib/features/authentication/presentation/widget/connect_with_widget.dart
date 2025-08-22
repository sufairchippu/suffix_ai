import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/svg_constants.dart';
import '../../../../core/utils/ui_utils.dart';

class ConnectWithWidget extends StatelessWidget {
  const ConnectWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Uiutils.getTextWidget(context, 'Connect With ...'),
        SizedBox(height: 6.rh(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30.rw(context),
          children: [
            CustomCircleImageWidget(
              firstLetter: 'G',
              onTap: () {},
              icon: SvgConstants.google,
            ),
            CustomCircleImageWidget(
              firstLetter: 'A',
              onTap: () {},
              icon: SvgConstants.apple,
              height: 45.rh(context),
              width: 50.rw(context),
            ),
            CustomCircleImageWidget(
              firstLetter: 'F',
              onTap: () {},
              icon: SvgConstants.faceBokk,
            ),

            // CircleAvatar(
            //   radius: 35.rf(context),
            //   backgroundImage: Uiutils.(ImageConstants.google),
            // ),
          ],
        ),
      ],
    );
  }
}

class CustomCircleImageWidget extends StatelessWidget {
  const CustomCircleImageWidget({
    super.key,
    required this.onTap,
    this.height,
    this.width,
    required this.icon,
    this.netwrkImage,
    this.assetImage,
    required this.firstLetter,
    this.boxColor,
  });
  final void Function()? onTap;
  final double? height;
  final double? width;
  final String? icon;
  final String? netwrkImage;
  final String? assetImage;
  final String firstLetter;
  final Color? boxColor;

  Widget _buildChild(BuildContext context) {
    if (icon != null) {
      return Uiutils.getSvg(boxfit: BoxFit.contain, icon!);
    } else if (assetImage != null) {
      return Uiutils.getassetImage(assetImage!);
    } else if (netwrkImage != null) {
      return Uiutils.getNetworkImage(netwrkImage!);
    } else {
      return Uiutils.getTextWidget(
        context,
        firstLetter.characters.first.split('/').first.toUpperCase(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40.rh(context),
        width: width ?? 47.rw(context),
        decoration: BoxDecoration(
          color: boxColor ?? CupertinoColors.transparent,
          shape: BoxShape.circle,
          // color: context.textColor,
        ),
        child: Center(child: _buildChild(context)),
      ),
    );
  }
}
