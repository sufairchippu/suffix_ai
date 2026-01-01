import 'dart:developer';
import 'dart:io';
import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/constants/models/models.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/service/download/download.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/core/service/network/dio/image_genrate_provider.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/banana/presentation/provider/imag_genratio_provider.dart';
import 'package:clean_architutre_learn/features/banana/presentation/widget/filter_carosal_widget.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final genrateImage = ref.watch(imaginNotifierProvider);
    int selected = ref.watch(filterNumberNano);
    final TextEditingController promptController = TextEditingController();
    // CustomCarousalWidget//implemt this in the filterf widget
    late NanoSelectionModels promtTitles =
        CoreConstants.listofnanBananaSelction[widget.specificationsIndex];
    return CupertinoPageScaffold(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (genrateImage.hasValue || image.hasValue) {
            ref.read(imaginNotifierProvider.notifier).clear();
            ref.read(imagePickerNotifierProvider.notifier).clear();
          } else {
            context.pop();
          }
          // ref.read(imaginNotifierProvider.notifier).clear();
          // ref.read(imagePickerNotifierProvider.notifier).clear();
        },
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

                        ref.read(imaginNotifierProvider.notifier).clear();
                        ref.read(imagePickerNotifierProvider.notifier).clear();
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: context.mainDarkShadeColor,
                      ),
                    ),

                    // Spacer(),
                    const AppLogoWidget(logoNeeded: false),
                    // Spacer(),
                    genrateImage.when(
                      data: (data) => data != null && data.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                ref
                                    .read(
                                      supabaseImagesNotifierProvider.notifier,
                                    )
                                    .addImage(data);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.cloud_download,
                                    color: context.mainDarkShadeColor,
                                  ),
                                  Uiutils.getTextWidget(context, 'Upload'),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      error: (error, stackTrace) => const SizedBox(),
                      loading: () => const CircularProgressIndicator(),
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
                      log(
                        '${image.value?.name}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>',
                      );
                    },
                    height: 650.rh(context),
                    width: 380.rw(context),
                    bordercolor: context.greyFirstColor,
                    titile: "Add Image",
                    widget: genrateImage.when(
                      data: (genratedImage) {
                        return image.when(
                          data: (file) {
                            log('.  sleced filter$selected');
                            return genratedImage != null &&
                                    genratedImage.isNotEmpty
                                ? Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          image: DecorationImage(
                                            image: MemoryImage(genratedImage),

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10.rw(context),
                                        top: 10.rh(context),
                                        child: GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(
                                                  imaginNotifierProvider
                                                      .notifier,
                                                )
                                                .clear();
                                          },
                                          child: const Icon(
                                            CupertinoIcons.xmark_circle_fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                // ? Container(
                                //   child: Image.memory(
                                //       genraeImage,
                                //       fit: BoxFit.cover,
                                //       height: double.infinity,
                                //       width: double.infinity,
                                //     ),
                                // )
                                :
                                  // Container(
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(16),
                                  //           image: DecorationImage(
                                  //             image: FileImage(File(file.path)),
                                  //             fit: BoxFit.cover,
                                  //           ),
                                  //         ),
                                  //       ):
                                  file != null
                                ? Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(File(file.path)),

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        left: 10.rw(context),
                                        bottom: 5.rh(context),
                                        child: Row(
                                          mainAxisAlignment: selected == 0
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.end,
                                          children: [
                                            if (selected == 0) ...[
                                              SizedBox(
                                                width: 230.rw(context),
                                                child: CustomTextFormField(
                                                  controller: promptController,
                                                  prefixNeeded: false,
                                                  borderColor:
                                                      context.dynamicColor1,
                                                  boxColor:
                                                      context.primaryColor,
                                                  hintText: ' Custom Prompt',
                                                ),
                                              ),
                                            ],
                                            SizedBox(width: 10.rh(context)),
                                            CustomButtonWIdget(
                                              onTap: () {
                                                final promttt = selected > 0
                                                    ? promtTitles
                                                          .specifications[selected -
                                                          1]
                                                    : promptController.text;
                                                log('$promttt promtt msg');
                                                ref
                                                    .read(
                                                      imaginNotifierProvider
                                                          .notifier,
                                                    )
                                                    .getImageFromImage(
                                                      "${promtTitles.description}with$promttt",
                                                      file.path,
                                                    );
                                              },
                                              titile: 'Genratte',
                                              color: context.dynamicColor1,
                                              borderRadius: 10.rf(context),
                                              height: 35.rh(context),
                                              padding: 0,
                                              width: 100.rw(context),
                                            ),
                                          ],
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
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Uiutils.getTextWidget(
                            context,
                            'Something Went wrong',
                          ),
                        );
                      },

                      loading: () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Uiutils.getLottie(LottieConstant.chatScreen),
                          const CupertinoActivityIndicator(),
                        ],
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
                      genrateImage.when(
                        data: (data) => data != null && data.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  await Download.saveUnit8ListTodevice(
                                    context,
                                    data,
                                    DateTime.now().toIso8601String(),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.share_up,
                                      color: context.mainDarkShadeColor,
                                    ),
                                    Uiutils.getTextWidget(context, 'Download'),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        error: (error, stackTrace) =>
                            SizedBox(width: 60.rw(context)),
                        loading: () {
                          return SizedBox(width: 40.rw(context));
                        },
                      ),

                      SizedBox(width: 25.rw(context)),
                      Expanded(
                        child: SizedBox(
                          height: 120.rh(context),
                          child: CustomFilterSelectorWidget(
                            items: promtTitles.specifications,
                            firstItem: Column(
                              //spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: selected == 0
                                      ? 75.rh(context)
                                      : 60.rh(context),
                                  width: selected == 0
                                      ? 75.rw(context)
                                      : 60.rw(context),
                                  decoration: BoxDecoration(
                                    color: context.buttnColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(height: 16.rh(context)),

                                Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  size: selected == 0
                                      ? 15.rf(context)
                                      : 10.rh(context),
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
      ),
    );
  }
}
