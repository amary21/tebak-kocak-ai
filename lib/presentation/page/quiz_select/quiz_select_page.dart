import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizSelectPage extends StatelessWidget {
  const QuizSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    const textSecondary = Color(0xFF6c757d);
    const buttonSecondaryBackground = Color(0xFFE9ECEF);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pilih Mode Kuis',
                style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  context.push('/quiz-upload');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.add, size: 48),
                    SizedBox(height: 8),
                    Text('Buat Kuis', style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.push('/quiz-take');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonSecondaryBackground,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Column(
                  children: [
                    Icon(Icons.grid_on_rounded, size: 48, color: textSecondary),
                    const SizedBox(height: 8),
                    Text(
                      'Ikuti Kuis',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
