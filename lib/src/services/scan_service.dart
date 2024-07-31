import 'dart:convert';
import 'package:http/http.dart' as http;

class ScanService {
  static const String _baseUrl = 'http://10.0.2.2:3000/scans';

  // Function to save scan
  static Future<http.Response> saveScan(Map<String, dynamic> scanData) async {
    final url = Uri.parse('$_baseUrl/scans'); // Adjust the endpoint as necessary

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(scanData),
    );

    return response;
  }
}
