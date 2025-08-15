import 'package:flutter/material.dart';
import 'package:catch_app_info_from_fb_sample/presentation/view/third_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('SecondPage'),
          centerTitle: true
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdPage()),
              );
            },
            child: Text('thirdPageへ')
        ),
      ),
    );
  }
}
