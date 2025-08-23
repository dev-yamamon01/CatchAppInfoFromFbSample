import 'package:flutter/material.dart';
import 'package:catch_app_info_from_fb_sample/presentation/view/second_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catch_app_info_from_fb_sample/data/repository/app_info_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Text('HomePage'),
          centerTitle: true
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async{

              await ref.read(appInfoRepositoryProvider).setData();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            child: Text('SecondPageへ')
        ),
      ),
    );
  }
}
