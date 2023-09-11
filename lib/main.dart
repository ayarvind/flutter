import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login.dart';
import 'constant/themes.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moods',
      theme: ThemeData(
        primarySwatch: Themes.primaryColor(),
        fontFamily: 'quickSand',
      ),
      home: const Login(),
    );
  }
}
