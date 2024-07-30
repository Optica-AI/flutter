import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ResultScreen extends StatelessWidget {
  final  String diagnosis;

  ResultScreen({required this.diagnosis});

  Future<void> _saveResults() async {
    final url = "http://10.0.2.2:3000/results";

    final data = {
      diagnosis: diagnosis,
    };

    try{
      final response =  await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if(response.statusCode == 200) {
        //Print success message so I can check when I'm stressed
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            SnackBar(content: Text('Results saved successfully')),
        );
      }
      else{
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Saving results failed: ${response.reasonPhrase}')),
        );
      }
    }catch(e){
      //Handle errors before I lose my mind
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Error saving results: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results',
          style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.w600,
              fontFamily: 'Nunito'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, top: 30.0, right: 25.0, bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.deepPurple[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patient ID',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '#0008976',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 18.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '02 APRIL 2024',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 18.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan ID',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '#OT0006',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 18.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'GMT 14:17pm',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 18.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //________________________________________________________________
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Divider(
                thickness: 0.6,
                endIndent: 10.0,
              ),
            ),
            //________________________________________________________________
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                height: 450.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text('Name',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Nana Akua Adjei-Boateng',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      //_____________________________________________________
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.6,
                          endIndent: 10.0,
                        ),
                      ),
                      //_____________________________________________________
                      Padding(
                        padding: EdgeInsets.only(right:40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Age',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purple[900],
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text('27 yrs',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gender',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purple[900],
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text('F',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.purple[900],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //____________________________________________________
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.6,
                          endIndent: 10.0,
                        ),
                      ),
                      //____________________________________________________
                      Row(
                        children: [
                          Text('Date of Birth',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('01 APRIL 1997',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      //____________________________________________________
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.6,
                          endIndent: 10.0,
                        ),
                      ),
                      //___________________________________________________
                      Row(
                        children: [
                          Text('Glaucoma Status',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(diagnosis,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: diagnosis == 'POSITIVE' ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                  minimumSize: const Size(400, 50),
                ),
                onPressed: _saveResults ,
                child: Text(
                    'Save',
                  style: TextStyle(
                    color: Colors.purple[50],
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
