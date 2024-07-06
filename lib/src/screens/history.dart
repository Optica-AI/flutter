import 'package:flutter/material.dart';


class History extends StatelessWidget{
  @override
  Widget build(BuildContext Context){
    return Scaffold(
      appBar: AppBar(
        title: Text('History',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
    );
  }
}