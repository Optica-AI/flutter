import 'dart:io';
import 'package:image/image.dart' as img;

Future<List<List<List<List<double>>>>> preprocessImage(File imageFile) async {
  // Load the image file
  final image = img.decodeImage(await imageFile.readAsBytes())!;

  // Resize the image to match the model's input shape (224x224)
  final resizedImage = img.copyResize(image, width: 224, height: 224);

  // Prepare the input array with normalized pixel values
  List<List<List<List<double>>>> input = List.generate(
      1, // Batch size
          (i) => List.generate(
          224, // Height
              (j) => List.generate(
              224, // Width
                  (k) => List.generate(3, (l) => 0.0) // 3 color channels
          )
      )
  );

  for (int x = 0; x < 224; x++) {
    for (int y = 0; y < 224; y++) {
      final pixel = resizedImage.getPixel(x, y);
      input[0][x][y][0] = img.getRed(pixel) / 255.0;  // Red channel (normalized)
      input[0][x][y][1] = img.getGreen(pixel) / 255.0; // Green channel (normalized)
      input[0][x][y][2] = img.getBlue(pixel) / 255.0; // Blue channel (normalized)
    }
  }

  print('This is the preprocessed image: $input');
  return input;
}














// import 'dart:io';
// import 'package:image/image.dart' as img;
//
// Future<List<List<List<List<int>>>>> preprocessImage(File imageFile) async {
//   // Load the image file
//   final image = img.decodeImage(await imageFile.readAsBytes())!;
//
//   // Resize the image to match the model's input shape (224x224)
//   final resizedImage = img.copyResize(image, width: 224, height: 224);
//
//   // Prepare the input array without normalization
//   List<List<List<List<int>>>> input = List.generate(1, (_) => List.generate(224, (_) => List.generate(224, (_) => List.generate(3, (_) => 0))));
//
//   for (int x = 0; x < 224; x++) {
//     for (int y = 0; y < 224; y++) {
//       final pixel = resizedImage.getPixel(x, y);
//       input[0][x][y][0] = img.getRed(pixel);  // Red channel
//       input[0][x][y][1] = img.getGreen(pixel); // Green channel
//       input[0][x][y][2] = img.getBlue(pixel); // Blue channel
//     }
//   }
//
//   return input;
// }
//
//




// import 'dart:io';
// import 'package:image/image.dart' as img;
//
// Future<List<List<List<List<double>>>>> preprocessImage(File imageFile) async {
//   // Load the image file
//   final image = img.decodeImage(await imageFile.readAsBytes())!;
//
//   // Resize the image to match the model's input shape (224x224)
//   final resizedImage = img.copyResize(image, width: 224, height: 224);
//
//   // Normalize the image to the range [0, 1] or any other range expected by your model
//   List<List<List<List<double>>>> input = List.generate(1, (_) => List.generate(224, (_) => List.generate(224, (_) => List.generate(3, (_) => 0.0))));
//
//   for (int x = 0; x < 224; x++) {
//     for (int y = 0; y < 224; y++) {
//       final pixel = resizedImage.getPixel(x, y);
//       input[0][x][y][0] = img.getRed(pixel) / 255.0;  // Red channel
//       input[0][x][y][1] = img.getGreen(pixel) / 255.0; // Green channel
//       input[0][x][y][2] = img.getBlue(pixel) / 255.0; // Blue channel
//     }
//   }
//
//   return input;
// }
