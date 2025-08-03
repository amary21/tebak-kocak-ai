import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_launcher.png', height: 250),
            const SizedBox(height: 16),
            const Text(
              'TebakKocak.ai',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FredokaOne', // Custom logo font
                fontSize: 50, // Tailwind's text-6xl ≈ 56px
                color: Color(0xFF333333),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
