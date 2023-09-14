import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moods/routes.dart';
import 'constant/themes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/login',
      routes: routes,

      // initialRoute: '/home',
      // routes: routes,
    );
  }
}
