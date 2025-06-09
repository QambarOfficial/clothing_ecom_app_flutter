import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utils/app_theme.dart';
import 'data/database.dart';
import 'main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the box
  await Hive.initFlutter();
  await Hive.openBox('addresses');

  final addressStorage = AddressStorage();

  bool hasData = await addressStorage.hasAddresses();
  if (!hasData) {
    await addressStorage.addAddress(
      street: "India",
      city: "Delhi",
      state: "New Delhi",
      zip: "",
    );
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




// import 'package:flutter/material.dart';
// import '../utils/app_theme.dart';
// import 'data/database.dart';
// import 'main_wrapper.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final dbHelper = DatabaseHelper.instance;
//   await dbHelper.database; // Ensure the database is ready
//   bool hasData = await dbHelper.hasAddresses();
//
//   if (!hasData) {
//     await dbHelper.addAddress("India", "Delhi", "New Delhi", "");
//   }
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: AppTheme.appTheme,
//       debugShowCheckedModeBanner: false,
//       home: const MainWrapper(),
//     );
//   }
// }
