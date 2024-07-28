import 'package:flutter/material.dart';

class NavBar extends StatefulWidget{
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({Key? key, required this.currentIndex, required this.onTap}): super(key:key);
  @override
  State<NavBar> createState() => _Navbar();
}
class _Navbar extends State<NavBar>{
  bool isSelected = false;

  void select(){
    setState(() {
      isSelected = true;
    });
  }
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      unselectedItemColor: Colors.purple,
      selectedItemColor: Colors.deepPurple,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.document_scanner_outlined),
          activeIcon: Icon(Icons.document_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          activeIcon: Icon(Icons.info),
          label: 'T&Cs',
        ),
      ],
    );
  }
}
