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

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ScanScreen(),
    History(),
    Terms(),
  ];

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavBar(currentIndex: _selectedIndex, onTap: onItemTapped),
    );
  }
}