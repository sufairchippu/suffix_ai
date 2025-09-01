import 'package:clean_architutre_learn/core/router/app_router.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/service/local_storage/local_storage_service.dart';

import 'core/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  await dotenv.load(fileName: ".env");
  await ChatLocalDataSource().database;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
