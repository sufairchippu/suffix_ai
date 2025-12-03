import 'dart:io';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/core/service/network/dio/image_genrate_provider.dart';
import 'package:clean_architutre_learn/features/banana/presentation/widget/filter_carosal_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class NanoDisplayScreen extends ConsumerStatefulWidget {
  const NanoDisplayScreen({super.key, required this.specificationsIndex});
  final int specificationsIndex;
  @override
  ConsumerState<NanoDisplayScreen> createState() => _NanoDisplayScreenState();
}

class _NanoDisplayScreenState extends ConsumerState<NanoDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imagePickerNotifierProvider);
    // CustomCarousalWidget//implemt this in the filterf widget
    late List<String> promtTitles = CoreConstants
        .listofnanBananaSelction[widget.specificationsIndex]
        .specifications;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.rf(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: context.mainDarkShadeColor,
                    ),
                  ),

                  // Spacer(),
                  const AppLogoWidget(logoNeeded: false),
                  // Spacer(),
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.cloud_download,
                        color: context.mainDarkShadeColor,
                      ),
                      Uiutils.getTextWidget(context, 'Store'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.rh(context)),
              Expanded(
                // height: 650.rh(context),
                // width: double.infinity,
                child: CustomButtonWIdget(
                  onTap: () {
                    ref
                        .read(imagePickerNotifierProvider.notifier)
                        .pick(ImageSource.gallery);
                  },
                  height: 650.rh(context),
                  width: 380.rw(context),
                  bordercolor: context.greyFirstColor,
                  titile: "Add Image",
                  widget: image.when(
                    data: (file) {
                      return file != null
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: FileImage(File(file.path)),

                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 15.rw(context),
                                  bottom: 18.rh(context),
                                  child: CustomButtonWIdget(
                                    onTap: () {},
                                    titile: 'Genratte',
                                    color: context.dynamicColor1,
                                    borderRadius: 10.rf(context),
                                    height: 35.rh(context),
                                    padding: 0,
                                    width: 100.rw(context),
                                  ),
                                ),
                              ],
                            )
                          : null;
                    },
                    loading: () =>
                        const Center(child: CupertinoActivityIndicator()),
                    error: (e, st) => Center(
                      child: Uiutils.getTextWidget(
                        context,
                        "Error loading image: $e",
                      ),
                    ),
                  ),
                ),
              ),
              // Flexible(
              //     fit: FlexFit.loose,
              //   child: CustomCarousalWidget(
              //     widgets: List.generate(
              //       promtTitles.length,
              //       (index) => Row(
              //         children: [
              //           SizedBox(height: 55.rh(context), width: 100.rw(context)),
              //           GestureDetector(
              //             onTap: () {},
              //             child: Column(
              //               //spacing: 5.rh(context),
              //               children: [
              //                 Container(
              //                   height: 65.rh(context),
              //                   width: 60.rw(context),
              //                   decoration: BoxDecoration(
              //                     color: context.buttnColor,
              //                     shape: BoxShape.circle,
              //                   ),
              //                 ),
              //                 Icon(
              //                   CupertinoIcons.xmark_circle_fill,
              //                   size: 13.rf(context),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     provider: filterNumberNano,
              //   ),
              // ),
              SizedBox(height: 10.rh(context)),

              SizedBox(
                height: 145.rw(context),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.share_up,
                          color: context.mainDarkShadeColor,
                        ),
                        Uiutils.getTextWidget(context, 'Download'),
                      ],
                    ),
                    SizedBox(width: 25.rw(context)),
                    Expanded(
                      child: SizedBox(
                        height: 120.rh(context),
                        child: CustomFilterSelectorWidget(
                          items: promtTitles,
                          firstItem: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70.rh(context),
                                width: 65.rw(context),
                                decoration: BoxDecoration(
                                  color: context.buttnColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.xmark_circle_fill,
                                size: 13.rf(context),
                              ),
                            ],
                          ),
                          onChanged: (index) {
                            ref.read(filterNumberNano.notifier).state = index;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 5.rh(context)),
            ],
          ),
        ),
      ),
    );
  }
}
