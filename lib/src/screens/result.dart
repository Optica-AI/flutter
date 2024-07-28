import 'package:flutter/material.dart';

class Resultscreen extends StatelessWidget {
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
                  color: Colors.purple[100],
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
          ],
        ),
      ),
    );
  }
}
