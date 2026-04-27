import 'package:flutter/material.dart';
import 'package:tag4u/presentation/pages/main_shell.dart';

class Tag4UApp extends StatelessWidget {
  const Tag4UApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tag4U',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B6FFF)),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}
