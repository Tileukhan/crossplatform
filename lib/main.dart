// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: GoogleFonts.josefinSans(  // Example using the Lato font
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF34dbfe),
        ),
        body: LoginScreen(),
      ),
    );
  }
}
