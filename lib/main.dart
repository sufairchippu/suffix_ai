import 'dart:async';

import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/router/app_router.dart';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/service/local_storage/local_storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Future.wait([
    LocalStorageService.init(),
    ChatLocalDataSource().database,
    Supabase.initialize(
      url: AppConfig.mainUrl,
      anonKey: AppConfig.superbasePubishKey,
    ),
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.

  StreamSubscription<AuthState>? _authSub;
  @override
  void initState() {
    super.initState();

    _authSub = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;

      if (event == AuthChangeEvent.passwordRecovery) {
        // 👇 Navigate to your reset password screen
        appRouter.goNamed(RouteNames.newPass);
      }
      if (event == AuthChangeEvent.signedIn) {
        // Email confirmation auto login link
        appRouter.goNamed(RouteNames.home);
      }
    });
    // Supabase.instance.client.auth.onAuthStateChange.listen((event) {
    //   final chekingEvent = event.event;
    //   final chekingSession = event.session;

    //   if (chekingSession == AuthChangeEvent.passwordRecovery) {
    //     context.pushNamed(RouteNames.newPass);
    //   }

    //   //?>>>>> adddf anotherrr conditionsss in hereee
    // });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
  // StreamSubscription? _sub;
  // void initDeepLink() {
  //   _sub = uriLinkStream.listen((Uri? uri) async {
  //     if (uri.toString().contains("login")) {
  //       final session = await Supabase.instance.client.auth.getSessionFromUrl(
  //         uri!,
  //       );
  //       if (session != null) {
  //         Supabase.instance.client.auth.setSession(session as String);
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    ref.listen<WidgetsBinding>(Provider((ref) => WidgetsBinding.instance), (
      previous,
      next,
    ) {
      final brightness = MediaQuery.platformBrightnessOf(context);
      ref.read(themeProvider.notifier).updateSystemTheme(brightness);
    });
    return CupertinoApp.router(
      theme: theme,

      routerConfig: appRouter,
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      // home: Container(
      //   color: CupertinoColors.destructiveRed,
      //   height: 100,
      //   width: 100,
      // ),
    );
  }
}
