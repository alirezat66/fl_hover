import 'package:example/showcase_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover Effects Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            const Color(0xFFF6F1D1), // Original CSS --backgroundColor
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Color(0xFF444444),
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      home: const ShowcaseScreen(),
    );
  }
}
