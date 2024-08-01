import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/about.dart';
import 'package:optica_app/src/screens/legal_agreement.dart';
import 'package:optica_app/src/widgets/navbar.dart';

class Terms extends StatelessWidget {
//   @override
//   _TermsState createState() => _TermsState();
// }
// class _TermsState extends State<Terms>{
//     int selectedIndex = 0;
//
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms of use',
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
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
                },
                child: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    // fontFamily: 'Nunito',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                elevation: 0,
                side: BorderSide.none,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Divider(
              thickness: 0.6,
              endIndent: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LegalAgreement(),
                  ),
                );
              },
              child: Text(
                'Terms of Use',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                elevation: 0,
                side: BorderSide.none,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Divider(
              thickness: 0.6,
              endIndent: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
              child: Text(
                'Report a problem',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  // fontFamily: 'Nunito',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                elevation: 0,
                side: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: NavBar(currentIndex: currentIndex, onTap: onItemTapped),
    );
  }
}
