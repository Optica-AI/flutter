import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/history.dart';
import 'package:optica_app/src/screens/scan.dart';
import 'package:optica_app/src/screens/tcs.dart';
import 'package:optica_app/src/widgets/navbar.dart';

import 'home_screen.dart';

class Home extends StatefulWidget{
  @override
  _Home createState()=> _Home();
}

class _Home extends State<Home>{
  int _selectedIndex = 0;


  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBackFromScreen(){
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context){
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      ScanScreen(onBack: _onBackFromScreen),
      History(),
      Terms(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: _selectedIndex!= 1
          ? NavBar(
              currentIndex: _selectedIndex,
              onTap: onItemTapped) : null,
    );
  }
}