import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizTakePage extends StatefulWidget {
  const QuizTakePage({super.key});

  @override
  State<QuizTakePage> createState() => _QuizTakePageState();
}

class _QuizTakePageState extends State<QuizTakePage> {
  final TextEditingController _quizCodeController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _quizCodeController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _quizCodeController.removeListener(_updateButtonState);
    _quizCodeController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _quizCodeController.text.trim().isNotEmpty;
      if (_isButtonEnabled) {
        _showError = false;
      }
    });
  }

  void _startQuiz() {
    // Simulating an invalid code check
    // In a real app, this would be a check against a server
    final isValid = _quizCodeController.text.trim().toUpperCase() == 'VALID123';

    setState(() {
      _showError = !isValid;
    });

    if (isValid) {
      // Navigate to quiz form page
      context.push('/quiz-form');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define colors from the HTML design
    final primaryColor = Theme.of(context).colorScheme.primary; // #FFDF12
    final backgroundColor = Theme.of(context).colorScheme.background; // #FFFFFF
    final textPrimary = Theme.of(context).colorScheme.onBackground; // #1F2937
    final textSecondary = const Color(0xFF6B7280); // #6B7280

    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/quiz-select'),
        ),
        title: const Text(
          'Ikuti Kuis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // Main content
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lock icon
                Icon(
                  Icons.lock,
                  size: 96,
                  color: primaryColor,
                ),
                const SizedBox(height: 16),

                // Title and description
                const Text(
                  'Siap untuk Tertawa?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan kode kuis untuk memulai petualangan kocakmu!',
                  style: TextStyle(
                    color: textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Quiz code input
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _quizCodeController,
                        decoration: InputDecoration(
                          hintText: 'Contoh: ABCD12',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.characters,
                      ),

                      // Error message
                      if (_showError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            'Kode kuis tidak valid atau tidak ditemukan. Silakan periksa kembali kode Anda.',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Start quiz button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isButtonEnabled ? _startQuiz : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: textPrimary,
                            disabledBackgroundColor: primaryColor.withOpacity(0.5),
                            disabledForegroundColor: textPrimary.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Mulai Kuis',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Footer
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Ditenagai oleh AI Kocak',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
