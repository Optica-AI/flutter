import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';

class ResultScreen extends StatelessWidget {
  final String? patientId;
  final String? patientName;
  final String? patientAge;
  final String? patientGender;
  final String? patientDOB;
  final String imagePath;
  final  String diagnosis;
  final String timeStamp;


  ResultScreen({
    required this.patientId,
    required this.imagePath,
    required this.diagnosis,
    required this.timeStamp,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientDOB,
  });

  // Future<Map<String, dynamic>> fetchPatientDetails(String patientId)async{
  //   final url = 'http://10.0.2.2:3000/patient';
  //
  //   try{
  //     final response = await http.get(Uri.parse(url));
  //
  //     if(response.statusCode == 200){
  //       return json.decode(response.body) as Map<String, dynamic>;
  //     }
  //     else{
  //       throw Exception('Failed to load patient details');
  //     }
  //   }
  //   catch(e){
  //     print('Error fetching patient details');
  //     throw (e);
  //   }
  // }

  Future<void> _saveResults(BuildContext context) async {
    final url = "http://10.0.2.2:3000/scans";

    final scan = {
      'patientId': patientId,
      'imagePath': imagePath,
      'diagnosis': diagnosis,
      'timeStamp': DateTime.now().toIso8601String(),
    };

    print('This is the scan object: $scan');

    try{
      final response =  await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(scan),
      );
      print(response);
      if(response.statusCode == 200) {
        //Print success message so I can check when I'm stressed
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Results saved successfully')),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saving results failed: ${response.reasonPhrase}')),
        );
      }
    }catch(e){
      //Handle errors before I lose my mind
      ScaffoldMessenger.of(context).showSnackBar(
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
                            '#000${patientId}',
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
                            timeStamp.split('T')[0],
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
                            '#OT0006', /// Check response for vibes
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
                            timeStamp.split('T')[1].split('.')[0],
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
                          Text('${patientName}',
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
                                Text('${patientAge} yrs',
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
                                Text(
                                  '${patientGender == 'Male' ? 'M' : 'F'}',
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
                          Text('${patientDOB}',
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
                onPressed: (){
                  _saveResults(context);
                } ,
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
