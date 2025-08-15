import 'package:flutter/material.dart';
import 'package:catch_app_info_from_fb_sample/presentation/view/second_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('HomePage'),
          centerTitle: true
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
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
