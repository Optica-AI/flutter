import 'dart:math';

import 'package:tflite_flutter/tflite_flutter.dart';

Interpreter? _interpreter;

Future<Interpreter> loadModel() async {
  _interpreter = await Interpreter.fromAsset('assets/Optica-Glaucoma.tflite');
  return _interpreter!;
}

Future<String> runInference(Interpreter interpreter, List<List<dynamic>> input) async {
  if (interpreter == null) throw Exception('Interpreter not initialized');

  var output = List.filled(2, 0).reshape([1, 2]);
  interpreter.run(input, output);

  print(output);
  // int predicted_value = max(output[0], output[1]);
  return output[0][0] > output[0][1] ? 'POSITIVE' : 'NEGATIVE';
}
