import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../core/providers/providers.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/repositories/auth_repository.dart';

// Auth state
class AuthState extends Equatable {
  final UserEntity? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, error, isAuthenticated];
}

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final AuthRepository _authRepository;

  AuthNotifier(this._signInUseCase, this._authRepository)
    : super(const AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final result = await _authRepository.getCurrentUser();
    result.fold(
      (failure) => state = state.copyWith(isAuthenticated: false),
      (user) =>
          state = state.copyWith(user: user, isAuthenticated: user != null),
    );
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _signInUseCase(
      SignInParams(email: email, password: password),
    );

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.toString()),
      (user) => state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        error: null,
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _authRepository.signUpWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.toString()),
      (user) => state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        error: null,
      ),
    );
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _authRepository.signOut();

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.toString()),
      (_) => state = const AuthState(isAuthenticated: false),
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(signInUseCaseProvider),
    ref.read(authRepositoryProvider),
  );
});
