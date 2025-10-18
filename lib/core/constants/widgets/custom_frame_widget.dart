import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/features/profile/presentation/widget/custom_buuble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFrameBodyWidget extends ConsumerStatefulWidget {
  const CustomFrameBodyWidget({super.key, required this.child});
  final Widget child;
  @override
  ConsumerState<CustomFrameBodyWidget> createState() =>
      _CustomFrameBodyWidgetState();
}

class _CustomFrameBodyWidgetState extends ConsumerState<CustomFrameBodyWidget> {
  // final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,

      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            IgnorePointer(
              child: Stack(
                children: [
                  Positioned(
                    left: -60.rw(context), // bleed out left
                    top: -60.rh(context), // bleed out top
                    child: CustomBubble(
                      size: 160.rf(context),
                      lightColor: context.buttnColor.withValues(alpha:0.6),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    right: -80.rw(context),
                    top: 100.rh(context),
                    child: CustomBubble(
                      size: 120.rf(context),
                      lightColor: context.buttnColor.withValues(alpha:0.4),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    left: -50.rw(context),
                    bottom: -40.rh(context),
                    child: CustomBubble(
                      size: 140.rf(context),
                      lightColor: context.buttnColor.withValues(alpha: 0.5),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    right: -60.rw(context),
                    bottom: -80.rh(context),
                    child: CustomBubble(
                      size: 180.rf(context),
                      lightColor: context.buttnColor.withValues(alpha: 0.3),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 26.rw(context),
                vertical: 40.rh(context),
              ),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
