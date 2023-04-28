import 'package:firebase_core/firebase_core.dart';
import 'package:firetuto/screens/splash_screen.dart';
import 'package:flutter/material.dart';

//ignore_for_file:prefer_const_constructors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
    );
  }
}
