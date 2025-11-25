import 'dart:developer';

import 'package:clean_architutre_learn/core/constants/widgets/app_logo_widget.dart';
import 'package:clean_architutre_learn/core/constants/widgets/custom_button_widget.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:clean_architutre_learn/core/utils/validation.dart';
import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final isSignUp = ref.read(loginMethodeProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    try {
      if (isSignUp) {
        await authNotifier.signup(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        _resetFormState();
        ref.read(loginMethodeProvider.notifier).state = false;
      } else {
        await authNotifier.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }

      final isLoggedIn = await LocalStorageService.getBool(
        LocalServiceKeys.IS_LOGGED_user,
      );

      if (isLoggedIn) {
        if (context.mounted) {
          context.pushReplacementNamed(RouteNames.home);
          // ref.read(authRepoProvider)
          // Uiutils.showSnackbar(context, 'Welcome back!');
        }
        _resetFormState();
      } else {
        // Uiutils.showSnackbar(context, 'Authentication failed. Please try again.');
      }
    } catch (e, st) {
      log('Auth Error: $e', stackTrace: st);
      // Uiutils.showSnackbar(context, 'Something went wrong. Please try again.');
    }
  }

  void _resetFormState() {
    _emailController.clear();
    _passwordController.clear();
    _confirmController.clear();
    ref.invalidate(loginPasswordProvider);
    ref.invalidate(loginConformPasswordProvider);
    ref.invalidate(loginMethodeProvider);
    ref.invalidate(authErrorProvider);
  }

  @override
  Widget build(BuildContext context) {
    final obscurePass = ref.watch(loginPasswordProvider);
    final obscureConfirm = ref.watch(loginConformPasswordProvider);
    final isCreateACState = ref.watch(loginMethodeProvider);
    final loginState = ref.watch(authNotifierProvider);
    final loginError = ref.watch(authErrorProvider);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.rw(context)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>,
                  children: [
                    SizedBox(height: 90.rh(context)),
                    _buildHeaderMethod(context, isCreateACState),
                    SizedBox(height: 40.rh(context)),
                    // Email
                    _buildEmailField(context),

                    // Password
                    _buildPasswordField(context, obscurePass),

                    // Password
                    isCreateACState
                        ? _buildConfirmPassField(context, obscureConfirm)
                        : const SizedBox(height: 0),
                    if (loginError.isNotEmpty)
                      Consumer(
                        builder: (context, ref, child) {
                          final loginError = ref.watch(authErrorProvider);
                          return Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(
                              0.rf(context),
                              12.rf(context),
                              12.rf(context),
                              6.rf(context),
                            ),
                            child: Uiutils.getTextWidget(
                              textStyle: TextStyleType.errorText,
                              context,
                              loginError,
                              color: context.red,
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 10.rh(context)),
                    _buildButtonMethode(isCreateACState, context, loginState),

                    const Spacer(),
                    _buildJoinChooseMethode(context, isCreateACState),
                    SizedBox(height: 20.rw(context)),

                    const ConnectWithWidget(),

                    // SizedBox(height: 5.rh(context)),
                    // // Skip row
                    // _buildSkipButton(context),
                    SizedBox(height: 20.rh(context)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSkipButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(RouteNames.login);
            _emailController.clear();
            _passwordController.clear();
            _confirmController.clear();
            ref.read(loginPasswordProvider.notifier).state = true;
            ref.read(loginConformPasswordProvider.notifier).state = true;
            ref.read(loginMethodeProvider.notifier).state = false;
          },
          child: Uiutils.getTextWidget(context, 'Skip'),
        ),
        const Icon(CupertinoIcons.arrow_right_circle_fill),
      ],
    );
  }

  Row _buildJoinChooseMethode(BuildContext context, bool isCreateACState) {
    return Row(
      spacing: 10.rw(context),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Uiutils.getTextWidget(
          context,
          isCreateACState ? 'Already hav an acccount?' : "Never hav an acount!",
        ),
        GestureDetector(
          onTap: () {
            ref.read(authErrorProvider.notifier).state = '';
            ref.read(loginMethodeProvider.notifier).state = !ref
                .read(loginMethodeProvider.notifier)
                .state;
            _emailController.clear();
            _passwordController.clear();
            _confirmController.clear();
            ref.read(loginPasswordProvider.notifier).state = true;
            ref.read(loginConformPasswordProvider.notifier).state = true;
          },
          child: Uiutils.getTextWidget(
            context,
            isCreateACState ? 'Sign-In' : 'Sign-Up',
            textStyle: TextStyleType.mediumBold,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }

  Column _buildButtonMethode(
    bool isCreateACState,
    BuildContext context,
    AsyncValue<UserEntity?> loginState,
  ) {
    return Column(
      spacing: 0,
      children: [
        if (isCreateACState) ...[
          Uiutils.getTextWidget(
            context,
            "After Confirm its you in mail can Register",
          ),
          SizedBox(height: 10.rh(context)),
        ],
        GestureDetector(
          onTap: () => _handleAuth(context),
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
              child: loginState.when(
                data: (data) => Uiutils.getTextWidget(
                  context,
                  isCreateACState ? 'Register' : 'Login',
                  fs: 22.rf(context),
                  fw: FontWeight.w600,
                ),
                error: (error, stackTrace) => Uiutils.getTextWidget(
                  context,
                  isCreateACState ? 'Register' : 'Login',
                  fs: 22.rf(context),
                  fw: FontWeight.w600,
                ),
                loading: () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Uiutils.getTextWidget(
                      context,
                      isCreateACState ? 'Register' : 'Login',
                      fs: 22.rf(context),
                      fw: FontWeight.w600,
                    ),
                    CupertinoActivityIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWIdget(
              padding: 0,
              right: 80.rw(context),
              titile: 'Forgotten Password ?',
              textStyle: TextStyleType.extraSmallBold,
              textColor: context.primaryColor,
              // color: context.cardColor3,
              onTap: () => context.pushNamed(RouteNames.passForget),
            ),
          ],
        ),
      ],
    );
  }

  Padding _buildConfirmPassField(BuildContext context, bool obscureConfirm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
      child: Consumer(
        builder: (context, ref, child) {
          return CustomTextFormField(
            maxline: 1,
            controller: _confirmController,
            hintText: 'Re-enter Password',
            text: 'Password',
            onTap: () {
              ref.read(loginConformPasswordProvider.notifier).state =
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
    );
  }

  Padding _buildPasswordField(BuildContext context, bool obscurePass) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.rf(context)),
      child: Consumer(
        builder: (context, ref, child) {
          return CustomTextFormField(
            maxline: 1,
            controller: _passwordController,
            hintText: 'Enter Password',
            text: 'Password',
            onTap: () {
              ref.read(loginPasswordProvider.notifier).state = !ref
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
    );
  }

  Padding _buildEmailField(BuildContext context) {
    return Padding(
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
    );
  }

  Row _buildHeaderMethod(BuildContext context, bool isCreateACState) {
    return Row(
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
              isCreateACState ? 'Welcome to,' : 'Welccome back to,',
              textStyle: TextStyleType.subHeading,
              fs: isCreateACState ? 20 : null,
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
    );
  }
}
