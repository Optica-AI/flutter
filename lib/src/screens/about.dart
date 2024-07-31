import 'package:flutter/material.dart';
import 'package:optica_app/src/widgets/back_button.dart'; // Make sure this path is correct

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            // Uncomment if you want to use the custom back button
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Back_Button(),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Optica_text_logo.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, top: 5.0, right: 25.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Optica© your innovative companion in eye health and diagnostics. '
                          'Our app leverages advanced artificial intelligence technology to assist in '
                          'the early detection of glaucoma. Our aim is to make the diagnosis of glaucoma '
                          'more accessible and accurate by providing a cutting-edge tool that can be used '
                          'by healthcare professionals to ease their diagnostic procedure. '
                          'Optica Offers:',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      // softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left:30.0),
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 6,
                      ),
                      title: Text(
                        'Early Detection of Glaucoma',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 6,
                      ),
                      title: Text(
                        'User-Friendly Interface',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 6,
                      ),
                      title: Text(
                        'Comprehensive Reports',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 6,
                      ),
                      title: Text(
                        'Regular Updates',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
