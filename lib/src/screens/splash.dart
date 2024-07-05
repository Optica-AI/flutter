import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext Context){
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/Optica_Logo.png',
        width:200.0,
        height:200.0,
        alignment:Alignment.center,),
      ),
    );
  }
}