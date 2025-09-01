import 'dart:io';

import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:clean_architutre_learn/features/profile/presentation/provider/profile_provider.dart';
import 'package:clean_architutre_learn/features/profile/presentation/widget/custom_buuble.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  // final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneNumber.text = '7994949328';
    username.text = 'Sufair RF';
    email.text = 'sufairdev@gmail.com';
    bool isUpade = true;
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
                      lightColor: context.buttnColor.withOpacity(0.6),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    right: -80.rw(context),
                    top: 100.rh(context),
                    child: CustomBubble(
                      size: 120.rf(context),
                      lightColor: context.buttnColor.withOpacity(0.4),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    left: -50.rw(context),
                    bottom: -40.rh(context),
                    child: CustomBubble(
                      size: 140.rf(context),
                      lightColor: context.buttnColor.withOpacity(0.5),
                      darkColor: context.dynamicColor3,
                    ),
                  ),
                  Positioned(
                    right: -60.rw(context),
                    bottom: -80.rh(context),
                    child: CustomBubble(
                      size: 180.rf(context),
                      lightColor: context.buttnColor.withOpacity(0.3),
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
              child: Column(
                // spacing: 15.rh(context),
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          size: 26.rf(context),
                          color: context.mainDarkShadeColor,
                        ),
                      ),
                      const Spacer(),
                      isUpade
                          ? CustomButtonWIdget(
                              widget: Row(
                                spacing: 12.rw(context),
                                children: [
                                  Uiutils.getTextWidget(
                                    context,
                                    'Save',
                                    textStyle: TextStyleType.mediumBold,
                                  ),
                                  Icon(
                                    CupertinoIcons.floppy_disk,
                                    color: context.mainDarkShadeColor,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Uiutils.modelBottomsheet(
                        context,
                        Padding(
                          padding: EdgeInsets.all(8.rf(context)),
                          child: Uiutils.getTextWidget(
                            context,
                            'Choose An Option',
                            textStyle: TextStyleType.mediumBold,
                            color: context.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.rf(context)),
                          child: Uiutils.getTextWidget(
                            context,
                            'Change Profile image from An Option',
                            textStyle: TextStyleType.smallBold,
                          ),
                        ),

                        [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              ref
                                  .read(profileImageNotifierProvider.notifier)
                                  .pick(ImageSource.camera);
                              context.pop();
                            },
                            child: Uiutils.getTextWidget(
                              context,
                              'Take Photo',
                              textStyle: TextStyleType.smallBold,
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              ref
                                  .read(profileImageNotifierProvider.notifier)
                                  .pick(ImageSource.gallery);
                              context.pop();
                            },
                            child: Uiutils.getTextWidget(
                              context,
                              'Select from Gallery',
                              textStyle: TextStyleType.smallBold,
                            ),
                          ),
                        ],
                        CupertinoActionSheetAction(
                          onPressed: () {
                            context.pop();
                          },
                          child: Uiutils.getTextWidget(context, "Cancel"),
                        ),
                      );
                    },
                    child: Consumer(
                      builder: (context, ref, child) {
                        final imageState = ref.watch(
                          profileImageNotifierProvider,
                        );
                        return Stack(
                          children: [
                            imageState.when(
                              data: (data) {
                                return Container(
                                  height: 140.rh(context),
                                  width: 140.rh(context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: data != null
                                          ? FileImage(File(data.path))
                                          : const AssetImage(ImageConstants.logo),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              error: (e, st) => Center(
                                child: Uiutils.getTextWidget(
                                  context,
                                  "Error loading image: $e",
                                ),
                              ),
                            ),
                            Positioned(
                              left: 27.rw(context),
                              bottom: 7.rh(context),
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  CupertinoIcons.camera_fill,
                                  color: context.textColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.rh(context)),

                  // ProfileSectionWidget(
                  //   controller: username,
                  //   type: 'Your Name',
                  //   icon: CupertinoIcons.person,
                  // ),
                  CustomButtonWIdget(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Uiutils.getTextWidget(
                          context,
                          username.text,
                          textStyle: TextStyleType.largeBold,
                        ),
                        Icon(
                          CupertinoIcons.pen,
                          color: context.mainDarkShadeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  ProfileSectionWidget(
                    controller: email,
                    type: 'E-Mail',
                    icon: CupertinoIcons.mail_solid,
                    oddColor: false,
                  ),
                  ProfileSectionWidget(
                    controller: phoneNumber,
                    type: 'Phone Number',
                    icon: CupertinoIcons.phone,
                  ),

                  // CupertinoListSection(
                  //   children: [
                  //     CupertinoListTile(
                  //       title: Uiutils.getTextWidget(context, 'Phone number'),
                  //       subtitle: CustomTextFormField(
                  //         obscure: false,
                  //         prefixNeeded: false,
                  //       ), //Uiutils.getTextWidget(context, 'title'),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 100.rh(context)),
                  CustomButtonWIdget(
                    top: 0.rh(context),
                    color: context.dynamicColor1.withValues(alpha: .3),
                    widget: Padding(
                      padding: EdgeInsets.all(8.rf(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Uiutils.getTextWidget(context, 'Intrest'),
                          const Icon(CupertinoIcons.paperplane),
                        ],
                      ),
                    ),
                  ),
                  CustomButtonWIdget(
                    top: 20.rh(context),
                    color: context.dynamicColor1.withValues(alpha: .3),
                    widget: Padding(
                      padding: EdgeInsets.all(8.rf(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Uiutils.getTextWidget(context, 'History'),
                          const Icon(CupertinoIcons.clock),
                        ],
                      ),
                    ),
                  ),

                  // Spacer(),
                  SizedBox(height: 70.rh(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [AppLogoWidget(logoNeeded: false,textSize: 12.rf(context),)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    super.key,
    required this.controller,
    required this.type,
    this.icon,
    this.oddColor = true,
  });

  final TextEditingController controller;
  final String type;
  final IconData? icon;
  final bool oddColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomButtonWIdget(
        onTap: () {
          Uiutils.showAlert(
            context,
            () {},
            "Change in  ",
            "",
            true,
            "Edit Your $type",
            context.buttnColor,
            somethingTodo: true,
            widget: Column(
              children: [
                CustomTextFormField(
                  obscure: false,
                  controller: controller,
                  prefixNeeded: false,
                ),
              ],
            ),
          );
        },
        padding: 20.rf(context),
        top: 10.rh(context),
        height: 90.rh(context),
        color: oddColor
            ? context.cardColor3.withValues(alpha: .9)
            : context.dynamicColor4,
        widget: Column(
          spacing: 6.rh(context),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Uiutils.getTextWidget(context, type),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon),
                Uiutils.getTextWidget(context, controller.text),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
