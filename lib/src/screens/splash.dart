import 'package:flutter/material.dart';
import 'home.dart';


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Future.delayed(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Home()));
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Optica_Logo.png',
              width:100.0,
              height:100.0,
              // alignment:Alignment.center,
            ),
            Image.asset('assets/images/Optica_text_logo.png',
              width:120.0,
              height:120.0,
              // alignment:Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}