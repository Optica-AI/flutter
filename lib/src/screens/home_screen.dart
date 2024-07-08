import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidelines',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text(
                  "Welcome, User!",
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              Text(
                'Get familiar with Optica with this video tutorial',
                style: TextStyle(
                    // fontSize:  ,
                    // fontFamily: ,
                    ),
              ),
              //Video placeHolder
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                child: Container(
                  height: 200.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Divider(
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
              ),
              //Text guidelines
              Container(
                // height: 100.0,
                width: 350.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple[50],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Did you know?',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              overflow: TextOverflow.clip,
                              color: Colors.purple[900],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text('Some random fun fact about the eyes that will get'
                                'user all giddy about it and also make them feel like they'
                                'have an eye doctor in their pockets. Hahahaha ahahaha '
                                'ahahaha',
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.purple[800],
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
