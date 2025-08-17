import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (authState.isAuthenticated)
            IconButton(
              onPressed: () {
                ref.read(authProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authState.isAuthenticated && authState.user != null) ...[
              Text(
                'Welcome, ${authState.user!.email}!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text('User ID: ${authState.user!.id}'),
              if (authState.user!.name != null)
                Text('Name: ${authState.user!.name}'),
            ] else ...[
              const Text('Please log in to continue'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to login page
                },
                child: const Text('Go to Login'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
