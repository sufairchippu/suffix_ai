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

class PassChangeScreen extends ConsumerStatefulWidget {
  PassChangeScreen({super.key, this.isFromSettings = false});
  bool isFromSettings;
  @override
  ConsumerState<PassChangeScreen> createState() => _PassChangeScreenState();
}

class _PassChangeScreenState extends ConsumerState<PassChangeScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obscurePass = ref.watch(loginPasswordProvider);
    final obscureConfirm = ref.watch(loginConformPasswordProvider);
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
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.rw(context)),

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
                    SizedBox(height: 60.rh(context)),
                    Uiutils.getTextWidget(
                      context,
                      'Reset Password',
                      textStyle: TextStyleType.mediumBold,
                      color: context.primarySecondColor,
                    ),
                    SizedBox(height: 10.rh(context)),
                    Uiutils.getTextWidget(
                      context,
                      'Set a new password for your account.\nJust enter the new password and confirm it below.',

                      textStyle: TextStyleType.mediumRegular,
                      fs: 13.rf(context),
                      color: context.primarySecondColor,
                      maxline: 3,
                    ),
                    SizedBox(height: 30.rh(context)),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return CustomTextFormField(
                            maxline: 1,
                            controller: _passwordController,
                            hintText: 'Enter Password',
                            text: 'Password',
                            onTap: () {
                              ref
                                  .read(loginPasswordProvider.notifier)
                                  .state = !ref
                                  .read(loginPasswordProvider.notifier)
                                  .state;
                            },
                            validator: Validators.emptyPasswordValidator(),
                            isWantsuffix: true,
                            obscure: obscurePass,
                            icon: CupertinoIcons.lock,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
                      child: Consumer(
                        builder: (context, ref, child) {
                          return CustomTextFormField(
                            maxline: 1,
                            controller: _confirmController,
                            hintText: 'Re-enter Password',
                            text: 'Password',
                            onTap: () {
                              ref
                                      .read(
                                        loginConformPasswordProvider.notifier,
                                      )
                                      .state =
                                  !obscureConfirm;
                            },
                            validator: (pass) {
                              if (pass == null || pass.isEmpty) {
                                return 'password must be submitted';
                              }
                              if (pass != _passwordController.text) {
                                return 'password were in miss-match';
                              } else {
                                return null;
                              }
                            },
                            isWantsuffix: true,
                            obscure: obscureConfirm,
                            icon: CupertinoIcons.lock,
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonWIdget(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            try {
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .newPaaword(_passwordController.text.trim())
                                  .then(
                                    (value) => Timer(
                                      Duration(seconds: 2),
                                      () => context.pop(),
                                    ),
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
                                "Reset",
                                fs: 12.rf(context),
                                fw: FontWeight.w600,
                              ),
                              error: (error, stackTrace) =>
                                  Uiutils.getTextWidget(
                                    context,
                                    "Reset",
                                    fs: 12.rf(context),
                                    fw: FontWeight.w600,
                                  ),
                              loading: () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Uiutils.getTextWidget(
                                    context,
                                    "Reset",
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
