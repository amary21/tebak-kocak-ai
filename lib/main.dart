import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tebak_kocak_ai/router.dart';
import 'core/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        surface: Colors.grey,
        onSurface: Colors.white,
      ),
    );

    // Initialize Supabase
    return ref
        .watch(supabaseInitProvider)
        .when(
          data: (_) => MaterialApp.router(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            routerConfig: router,
          ),
          loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
          error: (error, stack) => MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error initializing app: $error')),
            ),
          ),
        );
  }
}
