import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  // TODO: Initialise Supabase before runApp
  // await Supabase.initialize(url: '...', anonKey: '...');

  runApp(
    const ProviderScope(
      child: Tag4UApp(),
    ),
  );
}
