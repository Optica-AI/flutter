import 'package:flutter/material.dart';
import 'package:optica_app/main.dart';
import 'package:optica_app/src/widgets/back_button.dart';
import 'package:optica_app/src/widgets/problem_to.dart'; // Make sure this path is correct

class ProblemTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report a Problem',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 40.0, top: 0.0, right: 40.0, bottom: 0.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 150.0),
                Image.asset(
                  'assets/images/Optica_Logo.png',
                  width: 100.0,
                  height: 100.0,
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      'Enter problem in detail.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.purple[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Customize the border color if needed
                        width: 2.0, // Set the desired border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Customize the border color if needed
                        width: 2.0, // Set the desired border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Customize the border color if needed
                        width: 2.0, // Set the desired border width
                      ),
                    ),
                    labelText: 'Type here',
                    labelStyle: TextStyle(
                      color: Colors.grey, // Set the desired label text color
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: null, // Set to null to make it non-functional
                  child: Text('Submit',
                    style: TextStyle(
                      fontSize:20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Button background color
                    foregroundColor: Colors.purple, // Button text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
