import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unauthenticated());

  Future<void> login(String email, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      state = AuthState.authenticated(
        userId: '123',
        email: email,
        name: 'User', // Would come from API response
        joinDate: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      state = AuthState.authenticated(
        userId: '123',
        email: email,
        name: name,
        joinDate: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
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
