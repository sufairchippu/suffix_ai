import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/validation.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/image_constants.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/ui_utils.dart';
import '../widget/connect_with_widget.dart';
import '../widget/custom_login_painter.dart';
import '../widget/custom_textform_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final obscure = ref.watch(loginPasswordProvider);
    final obscure2 = ref.watch(loginConformPasswordProvider);
    final singup = ref.watch(loginMethodeProvider);

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

          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.rw(context)),
            child: Column(
              children: [
                SizedBox(height: 90.rh(context)),
                Row(
                  children: [
                    Uiutils.getassetImage(
                      ImageConstants.logo,
                      height: 100.rh(context),
                      width: 85.rw(context),
                    ),
                    SizedBox(width: 10.rw(context)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Uiutils.getTextWidget(
                          context,
                          singup ? 'Welcome to,' : 'Welccome back to,',
                          textStyle: TextStyleType.subHeading,
                          fs: singup ? 20 : null,
                        ),
                        // AppLogoWidget(logoNeeded: true,),
                        AppLogoWidget(
                          logoNeeded: false,
                          logoheit: 180.rf(context),
                          textColor: context.greyFirstColor,
                          textcolor2: context.greySecondColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40.rh(context)),
                // Email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
                  child: CustomTextFormField(
                    maxline: 1,
                    obscure: false,
                    controller: emailController,
                    icon: CupertinoIcons.mail,
                    text: 'E-Mail',
                    hintText: "Enter your Email",
                    validator: Validators.emailValidator(),
                  ),
                ),


                // Password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return CustomTextFormField(
                        maxline: 1,
                        controller: passwordController,
                        hintText: 'Enter Password',
                        text: 'Password',
                        onTap: () {
                          ref.read(loginPasswordProvider.notifier).state = !ref
                              .read(loginPasswordProvider.notifier)
                              .state;
                        },
                        validator: Validators.emptyPasswordValidator(),
                        isWantsuffix: true,
                        obscure: obscure,
                        icon: CupertinoIcons.lock,
                      );
                    },
                  ),
                ),


                // Password
                singup
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.rf(context),
                        ),
                        child: Consumer(
                          builder: (context, ref, child) {
                            return CustomTextFormField(
                              maxline: 1,
                              controller: conformController,
                              hintText: 'Re-enter Password',
                              text: 'Password',
                              onTap: () {
                                ref
                                        .read(
                                          loginConformPasswordProvider.notifier,
                                        )
                                        .state =
                                    !obscure2;
                              },
                              validator: (pass) {
                                if (pass != passwordController.text) {
                                  return 'password were in miss-match';
                                } else {
                                  return null;
                                }
                              },
                              isWantsuffix: true,
                              obscure: obscure2,
                              icon: CupertinoIcons.lock,
                            );
                          },
                        ),
                      )
                    : const SizedBox(height: 0),
                SizedBox(height: 40.rh(context)),
                GestureDetector(
                  onTap: () {

                    
                    context.pushReplacementNamed(RouteNames.home);
                    emailController.clear();
                    passwordController.clear();
                    conformController.clear();
                    ref.read(loginPasswordProvider.notifier).dispose();
                    ref.read(loginConformPasswordProvider.notifier).dispose();
                    ref.read(loginMethodeProvider.notifier).dispose();
                  },
                  child: Container(
                    height: 40.rh(context),
                    width: 200.rw(context),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: context.secondaryColor,
                      borderRadius: BorderRadius.circular(12.rf(context)),
                      // shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Uiutils.getTextWidget(
                        context,
                        singup ? 'Sign-up' : 'Login',
                        fs: 22.rf(context),
                        fw: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.rw(context)),
                Row(
                  spacing: 10.rw(context),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Uiutils.getTextWidget(
                      context,
                      singup
                          ? 'Already hav an acccount?'
                          : "Never hav an acount!",
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.read(loginMethodeProvider.notifier).state = !ref
                            .read(loginMethodeProvider.notifier)
                            .state;
                        emailController.clear();
                        passwordController.clear();
                        conformController.clear();
                        ref.read(loginPasswordProvider.notifier).state = true;
                        ref.read(loginConformPasswordProvider.notifier).state =
                            true;
                      },
                      child: Uiutils.getTextWidget(
                        context,
                        singup ? 'Sign-In' : 'Sign-Up',
                        color: context.toggleGrey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const ConnectWithWidget(),

                SizedBox(height: 45.rh(context)),
                // Skip row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteNames.login);
                        emailController.clear();
                        passwordController.clear();
                        conformController.clear();
                        ref.read(loginPasswordProvider.notifier).state = true;
                        ref.read(loginConformPasswordProvider.notifier).state =
                            true;
                        ref.read(loginMethodeProvider.notifier).state = false;
                      },
                      child: Uiutils.getTextWidget(context, 'Skip'),
                    ),
                    const Icon(CupertinoIcons.arrow_right_circle_fill),
                  ],
                ),
                SizedBox(height: 40.rh(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
