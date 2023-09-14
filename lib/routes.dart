import 'package:flutter/material.dart';
import 'package:moods/pages/login.dart';
import './pages/verfiy_otp.dart';
import './home_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomePage(),
  '/home': (context) => const HomePage(),
  '/login': (context) => const Login(),
  '/verify-otp': (context) => const VerifyOtp(
        verificationID: '',
      ),
};
