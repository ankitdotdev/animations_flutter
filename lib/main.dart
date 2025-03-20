import 'package:animations/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialSetup(),
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Animations',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          themeMode: ThemeMode.light,
          home: HomeScreen(),
        );
      },
    );
  }

  Future<void> _initialSetup() async {}
}
