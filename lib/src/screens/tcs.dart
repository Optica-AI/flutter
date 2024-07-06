import 'package:flutter/material.dart';

class Terms extends StatelessWidget{
  @override
  Widget build(BuildContext Context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of use',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('About',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
      ),
          ),
          Padding(
              padding: EdgeInsets.only(left:16.0),
              child: Divider(
                thickness: 1.0,
                endIndent: 20.0,
              ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Terms of Use',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16.0,
                  )
              ),
          ),


        ],
      ),
    );
  }
}