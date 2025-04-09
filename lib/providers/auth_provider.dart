import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unauthenticated());

  void login(String email, String password) {
    // In a real app, this would call an authentication API
    state = AuthState.authenticated(
      userId: '123',
      email: email,
      name: 'User', // Would come from API response
      joinDate: DateTime.now(),
    );
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final String? email;
  final String? name;
  final DateTime? joinDate;

  const AuthState.authenticated({
    required this.userId,
    this.email = 'user@example.com',
    this.name = 'User',
    this.joinDate,
  }) : isAuthenticated = true;

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        userId = null,
        email = null,
        name = null,
        joinDate = null;
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
