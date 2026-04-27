import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialise Supabase before runApp
  // await Supabase.initialize(url: '...', anonKey: '...');

  runApp(
    const ProviderScope(
      child: Tag4UApp(),
    ),
  );
}
