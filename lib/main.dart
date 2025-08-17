import 'package:flutter/material.dart';
import 'package:catch_app_info_from_fb_sample/presentation/view/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:catch_app_info_from_fb_sample/core/utils/app_version_utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AppVersionUtils().setListenerForAppUpdate(ref: ref, navigatorKey: navigatorKey);

    return MaterialApp(
      navigatorKey: navigatorKey, // ここで登録
      home: const HomePage(),
    );
  }
}

