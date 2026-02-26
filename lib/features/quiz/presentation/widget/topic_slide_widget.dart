import 'dart:ui';

import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedSegmentedControl extends ConsumerStatefulWidget {
  const AnimatedSegmentedControl({super.key});

  @override
  ConsumerState<AnimatedSegmentedControl> createState() =>
      _AnimatedSegmentedControlState();
}

class _AnimatedSegmentedControlState
    extends ConsumerState<AnimatedSegmentedControl>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _onTap(bool isTopic) {
    ref.read(topicSelecetedProvider.notifier).state = isTopic;

    HapticFeedback.selectionClick();

    // if (isTopic) {
    //   _controller.reverse();
    // } else {
    //   _controller.forward();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final isTopic = ref.watch(topicSelecetedProvider);
    if (isTopic && _controller.value != 0) {
      _controller.animateTo(0);
    } else if (!isTopic && _controller.value != 1) {
      _controller.animateTo(1);
    }
    return Container(
      height: 52.rh(context),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: //isTopic
            CupertinoColors.transparent,
        // : context.primaryColor.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          /// Sliding pill
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                  lerpDouble(-1, 1, _slideAnimation.value)!,
                  0,
                ),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .42,
                    decoration: BoxDecoration(
                      color: isTopic
                          ? context.primaryColor.withValues(alpha: .9)
                          : CupertinoColors.transparent,
                      borderRadius: BorderRadius.circular(22),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: CupertinoColors.black.withValues(alpha: .15),
                      //     blurRadius: 8,
                      //     offset: const Offset(0, 4),
                      //   ),
                      // ],
                    ),
                  ),
                ),
              );
            },
          ),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: CustomButtonWIdget(
                  onTap: () async {
                    ref.read(topicSelecetedProvider.notifier).state = true;
                    _onTap(true);

                    // topic = true;
                  },

                  titile: 'Topic',
                ),
              ),
              SizedBox(width: 10.rw(context)),
              Expanded(
                child: CustomButtonWIdget(
                  onTap: () {
                    ref.read(topicSelecetedProvider.notifier).state = false;
                    _onTap(false);
                  },

                  boxshadowColor: isTopic
                      ? CupertinoColors.transparent
                      : context.primaryColor.withValues(alpha: .9),
                  titile: 'Road-Map',
                ),
              ),
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () => _onTap(true),
              //     behavior: HitTestBehavior.opaque,
              //     child: Center(
              //       child: Text(
              //         'Topic',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w600,
              //           color: isTopic
              //               ? context.primaryColor
              //               : CupertinoColors.systemGrey,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () => _onTap(false),
              //     behavior: HitTestBehavior.opaque,
              //     child: Center(
              //       child: Text(
              //         'Road-Map',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w600,
              //           color: !isTopic
              //               ? context.primaryColor
              //               : CupertinoColors.systemGrey,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
