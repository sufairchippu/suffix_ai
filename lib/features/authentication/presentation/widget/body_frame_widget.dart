import 'package:clean_architutre_learn/core/constants/svg_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class BodyFrameWidget extends StatelessWidget {
  const BodyFrameWidget({
    super.key,
    required this.widget,
    this.position,
    this.height,
    required this.title,
    this.onBackTap,
  });
  final Widget widget;
  final double? position;
  final double? height;
  final String title;
  final VoidCallback? onBackTap;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (onBackTap != null) {
            onBackTap!();
          } else {
            context.pop();
          }
        }
      },
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          // color: context.commonBodyFrameColor,
          child: Stack(
            children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Container(
                  padding: MediaQuery.of(context).padding,
                  height: 340.rh(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [context.dynamicColor1, context.dynamicColor2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: onBackTap ?? () => context.pop(),
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              padding: EdgeInsets.all(12.rh(context)),
                              child: const Icon(CupertinoIcons.arrow_left),
                            ),
                          ),
                          Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: height ?? 85.rh(context),
                              ),
                              Uiutils.getTextWidget(
                                context,
                                title,

                                textStyle: TextStyleType.heading,
                                color: context.scaffoldColor,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.rh(context)),
                            child: Uiutils.getSvg(
                              SvgConstants.profilUndefined,
                              height: 32.rf(context),
                              //color: context.buttonForegroundColor
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: position ?? 200.rh(context),
                left: 0,
                right: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height -
                        (position ?? 210.rh(context)),
                  ),
                  child: SafeArea(top: false, child: widget),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom clipper for curved bottom
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
