import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: Container(
        child: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
