import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext Context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Optica_Logo.png',
              width:160.0,
              height:160.0,
              // alignment:Alignment.center,
            ),
            Image.asset('assets/images/Optica_text_logo.png',
              width:160.0,
              height:160.0,
              // alignment:Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}