import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

enum Gender { male, female }

class FormScreen extends StatelessWidget{
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Patient',
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
      body: Padding(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Text(
                "First Name",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Container(
                height: 39.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Enter first name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Text(
              "Last Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.purple[900],
                fontSize: 13.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'Nunito Sans',
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Container(
                height: 39.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Enter last name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Text(
                "Date of Birth",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
              child: Container(
                height: 39.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Select date of birth',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 0.0, top: 15.0, right: 0.0, bottom: 10.0),
              child: Text(
                "Gender",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ),
            // Padding(padding: EdgeInsets.only(left: 0.0, top: 15.0, right: 0.0, bottom: 10.0),
            //   child: Row(
            //     children: [
            //       CupertinoRadio<Gender>(
            //         value: Gender.male,
            //         groupValue: _selectedGender,
            //         onChanged: (Gender? value) {
            //           setState(() {
            //             _selectedGender = value;
            //           });
            //         },
            //       ),
            //       const SizedBox(width: 8), // Space between radio and text
            //       const Text('Male'),
            //     ],
            //   )
            // ),
          ],
        ),
      ),
    );
  }
}