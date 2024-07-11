import 'package:flutter/material.dart';
import 'package:optica_app/src/widgets/back_button.dart';

class AboutScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: (){
            //     Navigator.pop(context);
            //   },
            //   child: Back_Button(),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 10.0,top: 150.0,right: 10.0,bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Optica_text_logo.png',
                    width: 120.0,
                    height: 120.0,
                  ),
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0,top: 10.0,right: 25.0,bottom:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text('Optica© your innovative companion in eye health and diagnostics. '
                        'Our app leverages advanced artificial intelligence technology to assist in '
                        'the early detection of glaucoma. Our aim is to make the diagnosis of glaucoma '
                        'more accessible and accurate by providing a cutting-edge tool that can be used'
                        'by professionals and individuals alike.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}