import 'package:flutter/material.dart';
import 'package:catch_app_info_from_fb_sample/presentation/view/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:catch_app_info_from_fb_sample/data/repository/app_info_repository.dart';

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
    ref.listen(appInfoStreamProvider, (prev, next) {
      next.whenData((data) {
        if (data == null) return;

        final latestVersion = data['latestVersion'] as String?;
        if (latestVersion != null && latestVersion != '1.0.0') {
          final ctx = navigatorKey.currentContext;
          if (ctx != null) {
            showDialog(
              context: ctx,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text("アップデート必須"),
                content: const Text("新しいバージョンに更新してください。"),
                actions: [
                  TextButton(
                    onPressed: () {
                      // AppStoreやPlayStoreのURLへ遷移させる

                      // ダイアログを閉じる
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("更新する"),
                  ),
                ],
              ),
            );
          }
        }
      });
    });

    return MaterialApp(
      navigatorKey: navigatorKey, // ここで登録
      home: const HomePage(),
    );
  }
}

