import 'package:go_router/go_router.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_form/quiz_form_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_select/quiz_select_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_take/quiz_take_page.dart';
import 'package:tebak_kocak_ai/presentation/page/quiz_upload/quiz_upload_page.dart';
import 'package:tebak_kocak_ai/presentation/page/splash/splash_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen - initial route
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    
    // Quiz selection screen
    GoRoute(
      path: '/quiz-select',
      name: 'quiz-select',
      builder: (context, state) => const QuizSelectPage(),
    ),
    
    // Quiz upload screen
    GoRoute(
      path: '/quiz-upload',
      name: 'quiz-upload',
      builder: (context, state) => const QuizUploadPage(),
    ),
    
    // Quiz take screen
    GoRoute(
      path: '/quiz-take',
      name: 'quiz-take',
      builder: (context, state) => const QuizTakePage(),
    ),
    
    // Quiz form screen
    GoRoute(
      path: '/quiz-form',
      name: 'quiz-form',
      builder: (context, state) => const QuizFormPage(),
    ),
  ],
);