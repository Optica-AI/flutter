import 'dart:math';
import 'package:tflite_flutter/tflite_flutter.dart';

Interpreter? _classifierInterpreter;
Interpreter? _diagnosisInterpreter;

Future<void> loadModel() async {
  _classifierInterpreter = await Interpreter.fromAsset('assets/Fundus-Object-CLS.tflite');
  _diagnosisInterpreter = await Interpreter.fromAsset('assets/Optica-Glaucoma.tflite');
}

Future<bool> isFundusImage(List<List<List<List<double>>>> input) async {
  if(_classifierInterpreter == null) throw Exception("Classifier interpreter not initialized");

  var output = List.generate(1, (i) => List.generate(10, (j) => 0.0));
  _classifierInterpreter!.run(input, output);

  print('Classifier input: $input');
  print('Classifier output: $output');

  double maxValue = output[0].reduce(max);
  print('This is the maximum value in the classifier output: $maxValue');
  return output[0][0] == maxValue;
}

Future<String> runInference(List<List<List<List<double>>>> input) async {
  if (_diagnosisInterpreter == null) throw Exception('Interpreter not initialized');

  var output = List.generate(1, (i) => List.generate(2, (j) => 0.0));
  _diagnosisInterpreter!.run(input, output);

  print('Diagnosis model input: $input');
  print('Diagnosis model output: $output');

  return output[0][0] < output[0][1] ? 'POSITIVE':'NEGATIVE';
}








// import 'dart:math';
//
// import 'package:tflite_flutter/tflite_flutter.dart';
//
// Interpreter? _classifierInterpreter;
// Interpreter? _diagnosisInterpreter;
//
// Future<void> loadModel() async {
//   _classifierInterpreter = await Interpreter.fromAsset('assets/Fundus-Object-CLS.tflite');
//   _diagnosisInterpreter = await Interpreter.fromAsset('assets/Optica-Glaucoma.tflite');
// }
//
// Future<bool> isFundusImage(List<List<dynamic>> input) async {
//   if(_classifierInterpreter == null) throw Exception("Classifier interpreter not initialized");
//
//   var output = List.filled(10, 0).reshape([1, 10]);
//   _classifierInterpreter!.run(input, output);
//
//
//   print('Classifier input: $input');
//   print('Classifier output: $output');
//
//   double maxValue = output[0].map((e) => e as double).reduce((a, b) => a > b ? a : b);
//   print('This is the maximum value in the classifier output is: $maxValue');
//   return output[0][0] == maxValue;
// }
//
// Future<String> runInference(List<List<dynamic>> input) async {
//   if (_diagnosisInterpreter == null) throw Exception('Interpreter not initialized');
//
//   var output = List.filled(2, 0).reshape([1, 2]);
//   _diagnosisInterpreter!.run(input, output);
//
//   print('Diagnosis model input: $input');
//   print('Diganosis model output: $output');
//
//   // int predicted_value = max(output[0], output[1]);
//   return output[0][0] > output[0][1] ? 'POSITIVE' : 'NEGATIVE';
// }
