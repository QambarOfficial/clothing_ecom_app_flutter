import 'package:Fashan/data/database.dart';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.database; // Ensure the database is ready
  bool hasData = await dbHelper.hasAddresses();

  if (!hasData) {
    await dbHelper.addAddress("India", "Delhi", "New Delhi", "");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const MainWrapper(),
    );
  }
}
