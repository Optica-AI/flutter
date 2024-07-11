import 'package:flutter/material.dart';

class Back_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 32.0,
        height: 24.0,
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios),
            Text('Back'),
          ],
        ),
      ),
    );
  }
}