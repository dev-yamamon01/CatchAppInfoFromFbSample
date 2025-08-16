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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // グローバルに監視
    ref.listen(appInfoStreamProvider, (prev, next) {
      next.whenData((data) {
        print('検知');
        if (data == null) return;

        // 例えばバージョンチェックして強制アップデートダイアログを表示
        final latestVersion = data['latestVersion'] as String?;
        if (latestVersion != null && latestVersion != '1.0.0') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              title: const Text("アップデート必須"),
              content: const Text("新しいバージョンに更新してください。"),
              actions: [
                TextButton(
                  onPressed: () {
                    // AppStoreやPlayStoreのURLへ遷移させる
                  },
                  child: const Text("更新する"),
                ),
              ],
            ),
          );
        }
      });
    });

    return MaterialApp(
      home: const HomePage(),
    );
  }
}

