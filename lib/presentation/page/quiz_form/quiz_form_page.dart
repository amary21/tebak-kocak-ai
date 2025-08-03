import 'package:flutter/material.dart';

class QuizFormPage extends StatefulWidget {
  const QuizFormPage({super.key});

  @override
  State<QuizFormPage> createState() => _QuizFormPageState();
}

class _QuizFormPageState extends State<QuizFormPage> {
  // Selected option
  String? _selectedOption;
  // Whether the answer has been submitted
  bool _isAnswerSubmitted = false;
  // Mock data for the quiz
  final Map<String, dynamic> _quizData = {
    'questionNumber': 1,
    'totalQuestions': 10,
    'question': 'Apa yang paling mungkin dikatakan oleh karakter AI ini?',
    'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBBRWEplGfuDvANYQD2Yh1YJnufadaH0DevT1c-JJ9SIDsyjQrsD7Zs6UXdr2zm_iQzHBghKGHuNWsVZJjf1rh19V6L3SUdH_nmZDNk5QbH6OvcE6hHhK2nInYvWxnciV8X2W9YhOLYimy7CqWL1R9X1pWgBZ_N0ETTVQ39ZBKajBPVskPUZGAMxNz-uIwti3YI11uTAhAWD_kFN9zI99OPU_zbZo8Syf9CPly_y94JOj2qwTIPASx5nHiC7XPASMAA5J94gmbF7KA',
    'options': [
      {'id': 'A', 'text': '"Saya suka memproses data!"'},
      {'id': 'B', 'text': '"Saya sedang belajar tentang dunia."'},
      {'id': 'C', 'text': '"Saya ingin menjadi manusia."'},
      {'id': 'D', 'text': '"Saya suka bermain game!"'},
    ],
    'correctAnswer': 'C',
    'explanation': 'Jawaban yang benar adalah "Saya ingin menjadi manusia" karena gambar menunjukkan ekspresi kerinduan.'
  };

  void _selectOption(String optionId) {
    if (!_isAnswerSubmitted) {
      setState(() {
        _selectedOption = optionId;
      });
    }
  }

  void _submitAnswer() {
    if (_selectedOption != null && !_isAnswerSubmitted) {
      setState(() {
        _isAnswerSubmitted = true;
      });
    } else if (_isAnswerSubmitted) {
      // Navigate to next question or finish quiz
      debugPrint('Moving to next question...');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define colors from the HTML design
    final primaryColor = const Color(0xFFFFDF12); // --primary-color
    final backgroundColor = Colors.white; // --background-color
    final textPrimary = const Color(0xFF1E1E1E); // --text-primary
    final textSecondary = const Color(0xFF5C5C5C); // --text-secondary
    final choiceBorder = const Color(0xFFE0E0E0); // --choice-border
    final choiceSelectedBorder = primaryColor; // --choice-selected-border
    final choiceSelectedBg = const Color(0xFFFFFAE6); // --choice-selected-bg
    final choiceCorrectBg = const Color(0xFFE8F5E9); // --choice-correct-bg
    final choiceCorrectBorder = const Color(0xFF4CAF50); // --choice-correct-border
    final choiceIncorrectBg = const Color(0xFFFFEBEE); // --choice-incorrect-bg
    final choiceIncorrectBorder = const Color(0xFFF44336); // --choice-incorrect-border
    final feedbackCorrectText = const Color(0xFF388E3C); // --feedback-correct-text
    final feedbackIncorrectText = const Color(0xFFD32F2F); // --feedback-incorrect-text

    return Scaffold(
      backgroundColor: backgroundColor,
      // AppBar with back button
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Kuis',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      
      // Main content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    _quizData['imageUrl'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.error, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Question counter
              Text(
                'Soal ${_quizData['questionNumber']} dari ${_quizData['totalQuestions']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              
              // Question text
              Text(
                _quizData['question'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),

              // Feedback section (only shown after answer is submitted)
              if (_isAnswerSubmitted)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _selectedOption == _quizData['correctAnswer']
                        ? choiceCorrectBg
                        : choiceIncorrectBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _selectedOption == _quizData['correctAnswer']
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _selectedOption == _quizData['correctAnswer']
                            ? feedbackCorrectText
                            : feedbackIncorrectText,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedOption == _quizData['correctAnswer']
                                  ? 'Jawaban Anda Benar'
                                  : 'Jawaban Anda Salah',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedOption == _quizData['correctAnswer']
                                    ? feedbackCorrectText
                                    : feedbackIncorrectText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _quizData['explanation'],
                              style: TextStyle(
                                fontSize: 14,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),
              
              // Quiz options
              ..._quizData['options'].map<Widget>((option) {
                final String optionId = option['id'];
                final bool isSelected = _selectedOption == optionId;
                final bool isCorrect = optionId == _quizData['correctAnswer'];
                final bool isIncorrect = _isAnswerSubmitted && isSelected && !isCorrect;
                
                // Determine the styling based on the state
                Color borderColor = choiceBorder;
                Color backgroundColor = Colors.white;
                
                if (_isAnswerSubmitted) {
                  if (isCorrect) {
                    borderColor = choiceCorrectBorder;
                    backgroundColor = choiceCorrectBg;
                  } else if (isIncorrect) {
                    borderColor = choiceIncorrectBorder;
                    backgroundColor = choiceIncorrectBg;
                  }
                } else if (isSelected) {
                  borderColor = choiceSelectedBorder;
                  backgroundColor = choiceSelectedBg;
                }
                
                return GestureDetector(
                  onTap: () => _selectOption(optionId),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: borderColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio button
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isAnswerSubmitted && isCorrect
                                  ? choiceCorrectBorder
                                  : _isAnswerSubmitted && isIncorrect
                                      ? choiceIncorrectBorder
                                      : isSelected
                                          ? choiceSelectedBorder
                                          : choiceBorder,
                              width: 2,
                            ),
                            color: isSelected && !_isAnswerSubmitted
                                ? primaryColor
                                : Colors.transparent,
                          ),
                          child: isSelected || (_isAnswerSubmitted && isCorrect)
                              ? Center(
                                  child: Icon(
                                    _isAnswerSubmitted && isIncorrect
                                        ? Icons.close
                                        : Icons.check,
                                    size: 16,
                                    color: _isAnswerSubmitted && isCorrect
                                        ? choiceCorrectBorder
                                        : _isAnswerSubmitted && isIncorrect
                                            ? choiceIncorrectBorder
                                            : textPrimary,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        
                        // Option text
                        Expanded(
                          child: Text(
                            option['text'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      
      // Footer with next button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            top: BorderSide(
              color: choiceBorder,
              width: 1,
            ),
          ),
        ),
        child: ElevatedButton(
          onPressed: _selectedOption != null ? _submitAnswer : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: textPrimary,
            disabledBackgroundColor: primaryColor.withOpacity(0.5),
            disabledForegroundColor: textPrimary.withOpacity(0.5),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            _isAnswerSubmitted ? 'Lanjut' : 'Jawab',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}