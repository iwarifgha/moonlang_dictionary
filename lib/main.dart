import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlang_dictionary/firebase_options.dart';
import 'package:moonlang_dictionary/routes.dart';
import 'package:moonlang_dictionary/view/all_words_view.dart';
import 'package:moonlang_dictionary/view/base/base_view_builder.dart';
import 'package:moonlang_dictionary/view_model/theme_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseViewBuilder(
      provider: themeVmProvider,
      builder: (context, vmState, themeVm) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeVm.getTheme,
          routes: routes,
          debugShowCheckedModeBanner: false,
          home: const AppRouter(),
        );
      },
    );
  }
}

class AppRouter extends ConsumerStatefulWidget {
  const AppRouter({super.key});

  @override
  ConsumerState<AppRouter> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<AppRouter> {
  @override
  Widget build(BuildContext context) {
    //return HomeView();
    return AllWordsScreen();
  }
}
