import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/about.dart';
import 'package:optica_app/src/screens/history.dart';
import 'package:optica_app/src/screens/legal_agreement.dart';
import 'package:optica_app/src/screens/results.dart';
import 'package:optica_app/src/screens/splash.dart';
import 'package:optica_app/src/screens/tcs.dart';
import 'package:optica_app/src/widgets/back_button.dart';
import 'package:optica_app/src/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optica_app/src/screens/form.dart';
import 'package:optica_app/src/screens/home_screen.dart';
import 'package:optica_app/src/screens/home.dart';
import 'package:optica_app/src/screens/scan.dart';
import 'package:optica_app/src/screens/report_problem.dart';
import 'package:optica_app/src/widgets/problem_to.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Optica",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        primaryColor: Colors.white,
        fontFamily: GoogleFonts.nunito().fontFamily,
        appBarTheme: AppBarTheme(
          color: Colors.grey[100],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Set background color here
          unselectedItemColor: Colors.deepPurple[300],
          selectedItemColor: Colors.deepPurple[600],
        ),
      ),
      home: SplashScreen(),
    );
  }
}