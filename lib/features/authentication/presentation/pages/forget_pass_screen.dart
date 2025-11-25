import 'dart:async';

import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/core/utils/validation.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/provider/login_provider.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_login_painter.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/widget/custom_textform_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class ForgetPassScreen extends ConsumerWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final loginState = ref.watch(authNotifierProvider);
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: AuthBackgroundAnimation(
              waveColor: context.blueTwo,
              animationDuration: const Duration(seconds: 3),
              particleColor: context.secondaryColor,
            ), //CustomPaint(painter: TopBackgroundPainter())
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.rw(context)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 55.rh(context)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLogoWidget(
                          logoheit: 115.rh(context),
                          textSize: 28.rf(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 70.rh(context)),
                    Uiutils.getTextWidget(
                      context,
                      'Confirm Your Email',
                      textStyle: TextStyleType.mediumBold,
                      color: context.primarySecondColor,
                    ),
                    SizedBox(height: 10.rh(context)),
                    Uiutils.getTextWidget(
                      context,
                      'We’ve sent a verification link to your email address.\nPlease check your inbox and tap the link to verify \nyour account and set new password.',
                      textStyle: TextStyleType.mediumRegular,
                      fs: 13.rf(context),
                      color: context.primarySecondColor,
                      maxline: 3,
                    ),
                    SizedBox(height: 40.rh(context)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
                      child: CustomTextFormField(
                        maxline: 1,
                        obscure: false,
                        controller: _emailController,
                        icon: CupertinoIcons.mail,
                        text: 'E-Mail',
                        hintText: "Enter your Email",
                        validator: Validators.emailValidator(),
                      ),
                    ),
                    SizedBox(height: 25.rh(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonWIdget(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            try {
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .sendemailLink(_emailController.text)
                                  .then(
                                    (value) => Timer(Duration(seconds: 2), () {
                                      context.pop();
                                    }),
                                  );
                            } catch (e) {}
                          },
                          height: 35.rh(context),
                          width: 160.rw(context),
                          color: context.scaffoldColor,
                          borderRadius: 12.rf(context),
                          widget: Center(
                            child: loginState.when(
                              data: (data) => Uiutils.getTextWidget(
                                context,
                                "Get-Link",
                                fs: 12.rf(context),
                                fw: FontWeight.w600,
                              ),
                              error: (error, stackTrace) =>
                                  Uiutils.getTextWidget(
                                    context,
                                    "Get-Link",
                                    fs: 12.rf(context),
                                    fw: FontWeight.w600,
                                  ),
                              loading: () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Uiutils.getTextWidget(
                                    context,
                                    "Get-Link",
                                    fs: 12.rf(context),
                                    fw: FontWeight.w600,
                                  ),
                                  CupertinoActivityIndicator(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Uiutils.getassetImage(
                    //       ImageConstants.logo,
                    //       height: 100.rh(context),
                    //       width: 85.rw(context),
                    //     ),
                    //     SizedBox(width: 10.rw(context)),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Uiutils.getTextWidget(
                    //           context,
                    //           'Welcome to Welccome back to,',
                    //           textStyle: TextStyleType.subHeading,
                    //           fs: 20,
                    //         ),
                    //         // AppLogoWidget(logoNeeded: true,),
                    //         AppLogoWidget(
                    //           logoNeeded: false,
                    //           logoheit: 180.rf(context),
                    //           textColor: context.greyFirstColor,
                    //           textcolor2: context.greySecondColor,
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
