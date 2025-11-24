import 'package:flutter/material.dart';

// EKRANLARI İÇE AKTAR
import 'screens/login_screen.dart';
import 'screens/add_habit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpetua',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/add'  : (context) => const AddHabitScreen(),
      },
      // İstersen geçici bir home da bırakabilirsin ama initialRoute varken gerekmez
      // home: const Scaffold(body: Center(child: Text('Hello Perpetua 👋'))),
    );
  }
}
