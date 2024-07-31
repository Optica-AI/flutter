import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';


class History extends StatefulWidget {
  final Map<String, dynamic>? newScan;

  History({this.newScan});

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History>{
  List<Map<String, dynamic>> _scans = [];

  final List<Color> _colorPalette = [
    Colors.deepPurple[100]!,
    Colors.deepPurple[200]!,
    Colors.deepPurple[300]!,
    // Colors.deepPurple[400]!,
    // Colors.deepPurple[500]!,
    // Colors.deepPurple[600]!,
  ];

  @override
  void initState() {
    super.initState();
    if(widget.newScan != null){
      _scans.add(widget.newScan!);
    }
    _fetchScans();
  }

  Future<void> _fetchScans() async{
    final url = "http://172.20.10.3:3000/scans";

    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200){
        setState(() {
          _scans = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      }
      else{
        throw Exception('Failed to load scans');
      }
    }
    catch(e){
      print("Error fetching scans: $e");
    }
  }

  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w500,
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
      body: _scans.isEmpty
          ? Center(child: Text('No scans taken'))
          : ListView.builder(
              itemCount: _scans.length,
              itemBuilder: (BuildContext context, int index) {
                final scan = _scans[index];
                final color = _colorPalette[index % _colorPalette.length];
                final createdAt = DateTime.parse(scan['createdAt']);
                final formattedTime =  DateFormat.Hm().format(createdAt);
                return Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: color
                      ),
                      // color: color,
                      child: ListTile(
                        title: Text('Scan ID: ${scan['patientId']}${scan['patientName']}'),
                        subtitle: Text('Diagnosis: ${scan['diagnosis']}'),
                        trailing: Text('${formattedTime}'),
                      ),
                    ),
                );
              },

      ),
    );
  }
}
