import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';

class PatientService {
  static const String baseURL = 'http://172.20.10.3:3000';

  static Future<http.Response> createPatient(Patient patient) async {
    final url = Uri.parse('$baseURL/patients');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(patient.toJson());

    return await http.post(url, headers: headers, body: body);
  }

  static Future<List<Patient>> getAllPatients() async {
    final response = await http.get(Uri.parse('$baseURL/patients'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((patient) => Patient.fromJson(patient)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }
}
