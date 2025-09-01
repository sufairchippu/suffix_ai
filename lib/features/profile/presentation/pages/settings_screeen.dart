import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/theme/theme_notifier.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/connect_with_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreeen extends ConsumerStatefulWidget {
  const SettingsScreeen({super.key});

  @override
  ConsumerState<SettingsScreeen> createState() => _SettingsScreeenState();
}

class _SettingsScreeenState extends ConsumerState<SettingsScreeen> {
  @override
  Widget build(BuildContext context) {
    final thememode = ref.watch(themeProvider);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {},
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.rw(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    AppLogoWidget(logoheit: 150.rf(context)),
                    const SizedBox(),
                  ],
                ),
                SizedBox(height: 20.rh(context)),

                CustomButtonWIdget(
                  onTap: () {
                    context.pushNamed(RouteNames.profile);
                  },
                  height: 79.rh(context),
                  color: context.blue.withAlpha(220),
                  widget: Row(
                    children: [
                      SizedBox(width: 10.rw(context)),
                      CustomCircleImageWidget(
                        onTap: () {},
                        icon: null,
                        height: 120,
                        boxColor: context.shimmerHighlightColor,
                      ),
                      SizedBox(width: 10.rw(context)),
                      Uiutils.getTextWidget(
                        context,
                        'Username ', //not login plz login condition
                        textStyle: TextStyleType.mediumBold,
                        color: context.dynamicColor4,
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: context.cardColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.rh(context)),
                SettingsSectionWidget(
                  thememode: thememode,
                  text: 'Theme',
                  icon: thememode.brightness == Brightness.light
                      ? CupertinoIcons.sun_max
                      : CupertinoIcons.moon,
                  iconcolor: context.primaryColor,
                  onTap: () {
                    Uiutils.modelBottomsheet(context, const SizedBox(), const SizedBox(), [
                      CupertinoListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.rf(context),
                              color: context.textColor,
                            ),
                          ),
                        ),
                        leading: Uiutils.getTextWidget(
                          context,
                          AppThemeMode.dark.name
                              .toString()
                              .capitalizeFirstLetter(),
                        ),
                      ),
                      CupertinoListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.rf(context),
                              color: context.textColor,
                            ),
                          ),
                        ),
                        leading: Uiutils.getTextWidget(
                          context,
                          AppThemeMode.light.name
                              .toString()
                              .capitalizeFirstLetter(),
                        ),
                      ),
                      CupertinoListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.rf(context),
                              color: context.textColor,
                            ),
                          ),
                        ),
                        leading: Uiutils.getTextWidget(
                          context,
                          AppThemeMode.system.name
                              .toString()
                              .capitalizeFirstLetter(),
                        ),
                      ),
                    ], const SizedBox());
                    // ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
                SizedBox(height: 20.rh(context)),
                SettingsSectionWidget(
                  thememode: thememode,
                  text: 'Terms & Conditions',
                  icon: CupertinoIcons.info_circle_fill,
                  iconcolor: context.primaryColor,
                  onTap: () {
                    Uiutils.modelBottomsheet(
                      context,
                      Uiutils.getTextWidget(context, "Terms & COndition"),
                      Uiutils.getTextWidget(
                        overFlow: TextOverflow.clip,
                        context,

                        '''Introduction
By downloading, accessing, or using this application, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully before using the app. If you do not agree with any part of these terms, you should not use the application.

Use of the Application
This application is provided for your personal and lawful use only. You agree not to misuse the app in any way, including attempting to disrupt its functionality, reverse-engineering the software, or using it for fraudulent or harmful purposes. Any unauthorized use of the application may result in restricted access or termination of your account.

Content and Services
We strive to provide accurate and reliable content within the app. However, we cannot guarantee that all information will always be complete, error-free, or continuously available. The app may be updated, changed, or improved without prior notice to enhance performance and user experience.

Privacy and Data
We respect your privacy and are committed to protecting your personal information. Data collected through the app will only be used to provide services, improve functionality, and deliver a better experience. We do not share personal data with third parties unless required by law or with your explicit consent.

Liability Disclaimer
You agree that the use of this application is at your own risk. We are not responsible for any loss, damage, or inconvenience caused directly or indirectly by the use of the app or reliance on its content. The app and its features are provided “as is” without warranties of any kind.

Changes to Terms
We may revise or update these terms and conditions from time to time. Any changes will take effect immediately upon being posted within the app. Continued use of the application after changes are made indicates your acceptance of the updated terms.

Contact Information
If you have any questions, feedback, or concerns regarding these terms, please reach out to us through the support or help section available inside the application.''',
                      ),
                      [],
                      CupertinoActionSheetAction(
                        onPressed: () {
                          context.pop();
                        },
                        child: Uiutils.getTextWidget(context, 'OK'),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.rh(context)),
                SettingsSectionWidget(
                  thememode: thememode,
                  text: 'About',
                  icon: CupertinoIcons.person_2_fill,
                  iconcolor: context.primaryColor,
                  onTap: () {
                    Uiutils.modelBottomsheet(
                      context,
                      Uiutils.getTextWidget(context, "About us"),
                      Uiutils.getTextWidget(
                        overFlow: TextOverflow.clip,
                        context,

                        '''Suffix AI is a smart learning platform designed to make studying easier, faster, and more engaging. With daily quizzes, simple tasks, and interactive tools, Suffix AI helps learners build knowledge step by step while keeping the process fun and effective.

The app features an AI-powered chatbot for instant answers and explanations, along with a question paper creation tool that lets you prepare practice sets for self-study or sharing. You can also use the photo-to-answer feature to capture questions from books or notes and get quick solutions powered by AI.

Suffix AI is built to support learners of all levels — whether you’re revising for exams, practicing with quizzes, or simply exploring new knowledge every day. Our mission is to provide a reliable digital companion for your learning journey.

We are constantly improving the platform to deliver better tools and experiences. If you have feedback or suggestions, please reach out to us through the app’s support section. Together, we can make learning smarter and more accessible for everyone''',
                      ),
                      [],
                      CupertinoActionSheetAction(
                        onPressed: () {
                          context.pop();
                        },
                        child: Uiutils.getTextWidget(context, 'OK'),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.rh(context)),
                SettingsSectionWidget(
                  thememode: thememode,
                  text: 'Logout',
                  icon: CupertinoIcons.square_arrow_right,
                  iconcolor: context.red.withValues(alpha: .6),
                  onTap: () {
                    Uiutils.showAlert(
                      context,
                      () {
                        context.pushReplacement(RouteNames.login);
                      },
                      'Logout',
                      'Are You Sure to Logout',
                      true,
                      'Logout',
                      context.red,
                    );
                  },
                ),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogoWidget(logoNeeded: false, textSize: 14.rf(context)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.thememode,
    required this.text,
    required this.onTap,
    required this.icon,
    this.iconcolor,
  });

  final CupertinoThemeData thememode;
  final String text;
  final void Function()? onTap;
  final IconData icon;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    return CustomButtonWIdget(
      borderRadius: 10,
      onTap: onTap,
      padding: 20,
      height: 59.rh(context),
      color: context.dynamicColor2.withValues(alpha: .1),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Uiutils.getTextWidget(context, text),
          Icon(icon, color: iconcolor),
        ],
      ),
    );
  }
}
