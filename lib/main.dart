import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/providers/auth_provider.dart';
import 'package:turftime/screens/auth_screen.dart';
import 'package:turftime/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: TurfTimeApp()));
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    return authState.isAuthenticated 
        ? const HomeScreen()
        : const AuthScreen();
  }
}

class TurfTimeApp extends StatelessWidget {
  const TurfTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurfTime',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}