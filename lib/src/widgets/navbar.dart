import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  State<NavBar> createState() => _Navbar();
}

class _Navbar extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.deepPurple[300],
          selectedItemColor: Colors.deepPurple[600],
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
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
      ),
    );
  }
}
