import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/add_habit_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpetua',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home' : (context) => const HomeScreen(),
        '/add'  : (context) => const AddHabitScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('No habits yet')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add');
          if (context.mounted && result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saved: $result')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
