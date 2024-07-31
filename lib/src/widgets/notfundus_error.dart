import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:optica_app/src/screens/scan.dart';

class NotFundus extends StatelessWidget {
  final VoidCallback onBack;

  NotFundus({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding:
            EdgeInsets.only(left: 40.0, top: 30.0, right: 40.0, bottom: 0.0),
        child: Container(
          padding:
              EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0, bottom: 10.0),
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.deepPurple,
                    size: 80,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ERROR!",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "The uploaded image is not a valid fundus image. Take a "
                            "fundus image for accurate analysis.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ScanScreen(onBack: onBack,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                ),
                child: Text(
                  "Retake Photo",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.purple[900], // Text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
