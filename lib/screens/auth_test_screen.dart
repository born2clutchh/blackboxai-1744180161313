import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/providers/auth_provider.dart';

class AuthTestScreen extends ConsumerWidget {
  const AuthTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authState.isAuthenticated) ...[
              Text('User ID: ${authState.userId}'),
              Text('Email: ${authState.email}'),
              Text('Name: ${authState.name}'),
              Text('Member since: ${authState.joinDate}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => authNotifier.logout(),
                child: const Text('Logout'),
              ),
            ] else ...[
              const Text('Not authenticated'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => authNotifier.login(
                  'test@example.com',
                  'password123',
                ),
                child: const Text('Login as Test User'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
