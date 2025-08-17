import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:catch_app_info_from_fb_sample/data/repository/app_info_repository.dart';
import 'package:flutter/material.dart';

class AppVersionUtils{

  void setListenerForAppUpdate({
    required WidgetRef ref,
    required GlobalKey<NavigatorState> navigatorKey}){
    ref.listen(appInfoStreamProvider, (prev, next) async {
      next.whenData((data) async {
        if (data == null) return;
        final ctx = navigatorKey.currentContext;
        final latestVersion = data['latestVersion'] as String?;
        if (latestVersion == null) return;

        final currentVersion = await getCurrentAppVersion();

        if (isVersionLower(currentVersion, latestVersion)) {
          // 最新より低い場合にダイアログ表示
          if (ctx != null) {
            showDialog(
              context: ctx,
              barrierDismissible: false,
              builder: (_) =>
                  AlertDialog(
                    title: const Text("アップデート必須"),
                    content: Text(
                        "バージョン $latestVersion に更新してください。\n(現在: $currentVersion)"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // TODO: AppStoreやPlayStoreへ遷移
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
  }

  Future<String> getCurrentAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  bool isVersionLower(String current, String latest) {

    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();

    for (var i = 0; i < latestParts.length; i++) {
      final c = (i < currentParts.length) ? currentParts[i] : 0;
      final l = latestParts[i];
      if (c < l) return true;
      if (c > l) return false;
    }
    return false; // 同じ or current >= latest
  }


}