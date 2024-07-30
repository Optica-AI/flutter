import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';

Interpreter? _classifierInterpreter;
Interpreter? _diagnosisInterpreter;

Future<void> loadModel() async {
  _classifierInterpreter = await Interpreter.fromAsset('assets/Fundus-Object-CLS.tflite');
  _diagnosisInterpreter = await Interpreter.fromAsset('assets/Optica-Glaucoma.tflite');
}

Future<bool> isFundusImage(List<List<dynamic>> input) async {
  if(_classifierInterpreter == null) throw Exception("Classifier interpreter not initialized");

  var output = List.filled(10, 0).reshape([1, 10]);
  _classifierInterpreter!.run(input, output);

  print('Classifier output: $output');
  return output[0][0] > output[0][1];
}

Future<String> runInference(List<List<dynamic>> input) async {
  if (_diagnosisInterpreter == null) throw Exception('Interpreter not initialized');

  var output = List.filled(2, 0).reshape([1, 2]);
  _diagnosisInterpreter!.run(input, output);

  print(output);
  // int predicted_value = max(output[0], output[1]);
  return output[0][0] > output[0][1] ? 'POSITIVE' : 'NEGATIVE';
}
