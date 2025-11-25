import 'dart:async';
import 'package:clean_architutre_learn/core/constants/image_constants.dart';
import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 3), ()  {
      // Now check login status
      final isLoggedIn = LocalStorageService.getBool(
        LocalServiceKeys.IS_LOGGED_user,
      );

      if (!isLoggedIn) {
        return context.goNamed(RouteNames.login);
      } else {
        context.goNamed(RouteNames.home);
      }
    });
  }
  // final authState = ref.read(authNotifierProvider);

  // authState.when(
  //   data: (data) {
  //     if (data == null) {
  //       return context.goNamed(RouteNames.login);
  //     } else {
  //       context.goNamed(RouteNames.home);
  //     }
  //   },
  //   error: (error, stackTrace) =>
  //       Center(child: Uiutils.getLottie(LottieConstant.chatScreen)),
  //   loading: () => const Center(child: CupertinoActivityIndicator()),
  // );
  //   });
  // }

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
