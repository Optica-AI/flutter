import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Optica",
      theme: ThemeData(
        primarySwatch: Colors.white70,
        primaryColor: Colors.deepPurple.shade400,
        accentColor: Colors.deepPurple.shade100,
        fontFamily: GoogleFonts.nunito(),
        appBarTheme: Colors.white70,

      ),
    );
  }
}