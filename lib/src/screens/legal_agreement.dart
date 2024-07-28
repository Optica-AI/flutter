import 'package:flutter/material.dart';

class LegalAgreement extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(''),
            Text(
              'Elevated Button',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'GoogleFonts.roboto().fontFamily',
              ),
            ),
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0, bottom:8.0),
              child: Flexible(
                child: Text(
                  'Terms of Use',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                'Welcome to Optica'
                    ' ("the App"). This App is operated by [Your Company Name] '
                    '("we", "us", "our"). By accessing or using our App, you agree '
                    'to comply with and be bound by the following terms and conditions '
                    '("Terms of Use"). If you do not agree with these Terms of Use, '
                    'you are not authorized to use this App.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '2. Purpose of the App',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                'The App is designed to assist healthcare professionals in diagnosing '
                    'glaucoma using artificial intelligence and machine learning technology. '
                    'The App provides diagnostic suggestions based on images '
                    'taken with a smartphone fundoscope and historical medical data.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '3. User Responsibilities',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                'Users of the App must: '
                    '\n\nBe licensed healthcare professionals authorized to diagnose and treat glaucoma.'
                    'Use the App in accordance with all applicable laws and regulations.'
                    'Ensure that the data entered into the App is accurate and complete.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '4. Data Collecetion and Use.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                '4.1. Types of Data Collected',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                '\n+ The App collects the following types of data:'
              '\n+ Patient diagnostic results related to glaucoma.'
              '\n+ Historical medical data, especially related to eye health.'
              '\n+ User interaction data with the App for performance and improvement purposes.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                '\n4.2. Use of Collected Data',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
              child: Text(
                '\n+ Collected data is used for the following purposes:'
              '\n+ Providing accurate diagnostic suggestions.'
                '\n+ Improving the accuracy and performance of our AI/ML models.'
                '\n+ Conducting research and analysis to enhance healthcare outcomes.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


