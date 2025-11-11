import 'dart:async';

import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/constants/lottie_constant.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/provider/login_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      final authState = ref.watch(authNotifierProvider);
      authState.when(
        data: (data) {
          if (data == null) {
            return context.pushReplacementNamed(RouteNames.login);
          } else {
            context.pushReplacementNamed(RouteNames.home);
          }
        },
        error: (error, stackTrace) =>
            Center(child: Uiutils.getLottie(LottieConstant.chatScreen)),
        loading: () => Center(child: CupertinoActivityIndicator()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SizedBox.expand(
          // 👈 forces it to take the full screen
          child: Center(
            child: Uiutils.getassetImage(
              height: 230.rh(context),
              width: 210.rw(context),
              ImageConstants.logo,
            ),
          ),
        ),
      ),
    );
  }
}
