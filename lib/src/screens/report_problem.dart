import 'package:flutter/material.dart';
import 'package:optica_app/src/widgets/back_button.dart';
import 'package:optica_app/src/widgets/problem_to.dart'; // Make sure this path is correct

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report a problem',
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
              left: 10.0, top: 100.0, right: 10.0, bottom: 10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Optica_text_logo.png',
                    width: 120.0,
                    height: 120.0,
                  ),
                ],
              ),
              Text(
                "How may we help?",
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.purple[900],
                ),
              ),
              SizedBox(height: 20.0,),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProblemTo(),
                              ),
                            );
                          },
                          child: Text(
                            'Bug or Glitch',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            elevation: 0,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(
                      thickness: 0.6,
                      endIndent: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProblemTo(),
                              ),
                            );
                          },
                          child: Text(
                            'Diagnostic Error',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            elevation: 0,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(
                      thickness: 0.6,
                      endIndent: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProblemTo(),
                              ),
                            );
                          },
                          child: Text(
                            'Feature Request',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            elevation: 0,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(
                      thickness: 0.6,
                      endIndent: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProblemTo(),
                              ),
                            );
                          },
                          child: Text(
                            'Other',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            elevation: 0,
                            side: BorderSide.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
