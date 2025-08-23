import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ThirdPage'),
          centerTitle: true
      ),
      body: Center(
        child: Text('これが最後のページです'),
      ),
    );
  }
}
