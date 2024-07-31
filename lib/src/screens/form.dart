import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import '../models/patient.dart';
import '../services/patient_service.dart';
import 'package:optica_app/src/screens/scan.dart';

enum Gender { male, female }

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
//   final _ageController = TextEditingController();
  final _dobController = TextEditingController();
  Gender? _selectedGender;
  DateTime? _selectedDate;

  bool _hasPreExistingConditions = false;

  final List<String> _conditions = [
    "Cataract",
    "Diabetic retinopathy",
    "Myopia",
    "Hyperopia",
    "Conjunctivitis",
    "Astigmatism",
    "Hypertensive retinopathy",
    "Keratitis",
  ];

  List<String> _selectedConditions = [];

  Future<void> _submitForm() async {
    if(_formKey.currentState!.validate()){
      final firstName = _firstnameController.text;
      final lastName = _lastnameController.text;
//       final age = int.parse(_ageController.text);
      final dob = _dobController.text;
      final gender = _selectedGender == Gender.male ? 'male' : 'female';

      //Age calculation
      int age = _calculateAge(_selectedDate);

      final patient = Patient(
          name: '$firstName $lastName',
          age: age,
          dob: dob,
          gender: gender,
          hasPreExistingConditions: _hasPreExistingConditions,
          preExistingConditions: _selectedConditions,
      );

      print('Submitting patient details: ${patient.toJson()}');

      final response = await PatientService.createPatient(patient);

      print('Response from backend: ${response.statusCode} ${response.body}');

      if(response.statusCode == 201){
        final responseData = json.decode(response.body);
        final patientId = responseData['id'].toString();
        print('This is the response data: $responseData');
        print('This is the ID from backend: $patientId');

        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            SnackBar(content: Text('Patient added successfully!'),
            ),
        );
        Navigator.pop(context, {patientId: patientId, responseData: responseData});
        print('I am leaving with patientid: $patientId');
        print('I am leaving with patientDetails: $responseData');

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => ScanScreen()),
        // );
      }
      else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Failed to add patient.')),
        );
      }
    }
  }

  int _calculateAge(DateTime? dob){
    if(dob == null){
        return 0;
    }
    final today = DateTime.now();
    int age = today.year -  dob.year;
    if(today.month < dob.month || (today.month == dob.month && today.day < dob.day)){
        age--;
    }
    return age;
  }

  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
    );
    if (picked !=null && picked != _selectedDate){
      setState(() {
        _selectedDate =  picked;
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Patient',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w600,
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
        padding:EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                      controller: _firstnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Enter first name',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter the first name.';
                        }
                      },
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
                      controller: _lastnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                        labelText: 'Enter last name',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter a last name.';
                        }
                      },
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
                      controller: _dobController,
                      readOnly: true,
                      onTap: ()=> _selectDate(context),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Select date of birth',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Select a date of birth';
                        }
                        return null;
                      },
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
                Row(
                  children: [
                    Expanded(
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio<Gender>(
                            value: Gender.male,
                            groupValue: _selectedGender,
                            onChanged: (Gender? value){
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        )
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Female'),
                        leading: Radio<Gender>(
                          value: Gender.female,
                          groupValue: _selectedGender,
                          onChanged: (Gender? value){
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //Some checkbox here
                    Checkbox(
                        value: _hasPreExistingConditions,
                        onChanged: (bool? value){
                          setState(() {
                            _hasPreExistingConditions = value ?? false;
                          });
                        }),
                    Text('Any pre-existing conditions'),
                  ],
                ),
                if(_hasPreExistingConditions) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Select pre-existing conditions:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: _conditions.length,
                      itemBuilder: (context, index){
                        return CheckboxListTile(
                            title: Text(_conditions[index]),
                            value: _selectedConditions.contains(_conditions[index]),
                            onChanged: (bool? selected){
                              setState(() {
                                if(selected == true){
                                  if(_selectedConditions.length < 7){
                                    _selectedConditions.add(_conditions[index]);
                                  }
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('You can only select 7 conditions'),
                                      ),
                                    );
                                  }
                                }
                                else{
                                  _selectedConditions.remove(_conditions[index]);
                                }
                              });
                            }
                        );
                      },
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[900],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _submitForm,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}