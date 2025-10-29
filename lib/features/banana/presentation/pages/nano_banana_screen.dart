import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/carousal/custom_carousal_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/carousal/providers.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/chat/presentation/widgets/chat_bakground_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NanoBananaScreen extends ConsumerStatefulWidget {
  const NanoBananaScreen({super.key});

  @override
  ConsumerState<NanoBananaScreen> createState() => _NanoBananaScreenState();
}

class _NanoBananaScreenState extends ConsumerState<NanoBananaScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: CupertinoPageScaffold(
        child: Stack(
          children: [
            Positioned.fill(
              child: GradientMotionBackground(
                colorr1: context.shimmerHighlightColor,
                colorr2: context.primaryColor,
                colorr3: context.subTextColor,
              ),
            ),

            Align(
              alignment: AlignmentGeometry.center,
              child: Padding(
                padding: EdgeInsets.only(top: 220.rh(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Uiutils.getTextWidget(
                      context,
                      'Swipe towaord needed',
                      textStyle: TextStyleType.largeBold,
                    ),
                    SizedBox(height: 60.rh(context)),

                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomCarousalWidget(
                        widgets: CoreConstants.listofnanBananaSelction
                            .asMap()
                            .entries
                            .map((element) {
                              final index = element.key;
                              final eValue = element.value;
                              return CustomButtonWIdget(
                                borderRadius: 12.rf(context),
                                color: context.dynamicColor2,
                                height: 100.rh(context),
                                padding: 25.rf(context),
                                left: 30.rw(context),
                                right: 30.rw(context),
                                widget: Column(
                                  children: [
                                    SizedBox(height: 30.rh(context)),
                                    Uiutils.getTextWidget(
                                      context,
                                      eValue.title,
                                      textStyle: TextStyleType.heading,
                                      fs: 26.rf(context),
                                    ),
                                    SizedBox(height: 70.rh(context)),
                                    Uiutils.getTextWidget(
                                      context,
                                      eValue.description,
                                      textStyle: TextStyleType.mediumSemiBold,
                                      fs: 25.rf(context),
                                      overFlow: TextOverflow.visible,
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(CupertinoIcons.play_fill),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  context.pushNamed(
                                    RouteNames.nanoBananaDisplay,
                                    pathParameters: {'specilization':'$index' },
                                  );
                                },
                              );
                            })
                            .toList(),

                        //[
                        // CustomButtonWIdget(
                        //   borderRadius: 12.rf(context),
                        //   color: context.dynamicColor2,
                        //   height: 100.rh(context),
                        //   padding: 10.rf(context),
                        //   left: 50.rw(context),
                        //   right: 50.rw(context),
                        //   widget: Column(
                        //     children: [
                        //       Uiutils.getTextWidget(
                        //         context,
                        //         'topic Description',
                        //       ),
                        //       Spacer(),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [Icon(CupertinoIcons.play_fill)],
                        //       ),
                        //     ],
                        //   ),
                        //   onTap: () {},
                        // ),
                        //   CustomButtonWIdget(
                        //     borderRadius: 12.rf(context),
                        //     color: context.dynamicColor2,
                        //     height: 100.rh(context),
                        //     padding: 10.rf(context),
                        //     left: 50.rw(context),
                        //     right: 50.rw(context),
                        //     widget: Column(
                        //       children: [
                        //         Uiutils.getTextWidget(
                        //           context,
                        //           'topic Description',
                        //         ),
                        //         Spacer(),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.end,
                        //           children: [Icon(CupertinoIcons.play_fill)],
                        //         ),
                        //       ],
                        //     ),
                        //     onTap: () {},
                        //   ),
                        // ],
                        provider: nanoBananaProvider,
                      ),
                    ),
                    SizedBox(height: 100.rh(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
