import 'package:flutter/material.dart';
import 'package:tebak_kocak_ai/presentation/page/home/home_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_form/quiz_form_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_select/quiz_select_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_take/quiz_take_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_upload/quiz_upload_page.dart';
import 'package:tebak_kocak_ai/presentation/page/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryYellow = Color(0xFFFFDF12);
    const onPrimaryColor = Colors.black;

    final lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'SplineSans',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontWeight: FontWeight.w400),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryYellow,
        onPrimary: onPrimaryColor,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primaryYellow,
        onPrimary: onPrimaryColor,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.black,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.white,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const QuizFormPage(),
    );
  }
}
