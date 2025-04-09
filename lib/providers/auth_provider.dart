import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unauthenticated());

  void login(String email, String password) {
    // In a real app, this would call an authentication API
    state = const AuthState.authenticated(userId: '123');
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isAuthenticated;
  final String? userId;

  const AuthState.authenticated({required this.userId})
      : isAuthenticated = true;

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        userId = null;
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
