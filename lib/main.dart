import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/splash.dart';
// import 'package:google_fonts/google_fonts.dart';

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
        scaffoldBackgroundColor: Colors.white70,
        primaryColor: Colors.deepPurple.shade400,
        // fontFamily: GoogleFonts.nunito().fontFamily,
        appBarTheme: const AppBarTheme(
          color: Colors.white70,
        ),
      ),
      home: SplashScreen(),
    );
  }
}