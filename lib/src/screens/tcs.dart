import 'package:flutter/material.dart';
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16.0,
                color: Colors.black,
              ),
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
            padding: EdgeInsets.all(16.0),
            child: Text('Terms of Use',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                )),
          ),Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Divider(
              thickness: 0.6,
              endIndent: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Report a problem',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                )),
          ),
        ],
      ),
      // bottomNavigationBar: NavBar(currentIndex: currentIndex, onTap: onItemTapped),
    );
  }
}
