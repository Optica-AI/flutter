import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/results.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/tflite_model.dart';
import '../utils/image_processing.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  late Future<void> _initialControllerFuture;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    _initialControllerFuture = controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initialControllerFuture;
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, '${DateTime.now()}.jpg');
      final image = await controller.takePicture();
      final File savedImage = File(imagePath);

      savedImage.writeAsBytesSync(await image.readAsBytes());
      setState(() {
        this.imagePath = imagePath;
      });

      // Dispose the camera controller after taking the picture
      controller.dispose();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  Future<void> _retakePicture() async {
    // Reinitialize the camera for retaking the picture
    await _initializeCamera();
    setState(() {
      imagePath = null;
    });
  }

  Future<void> _savePhoto() async {
    if (imagePath != null) {
      try {
        //Process image
        final preprocessedImage = await preprocessImage(File(imagePath!));

        final isFundus = await isFundusImage(preprocessedImage);


        if(isFundus){
          //run inference
          final diagnosis = await runInference(preprocessedImage);
          print('This is the diagnosis: $diagnosis');

          //Navigate to diagnosis screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(diagnosis: diagnosis),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('The captured image is not a fundus image. Please retake picture.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing image: $e')),
        );
      }
//
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan',
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
      body: Center(
        child: imagePath == null
            ? FutureBuilder<void>(
                future: _initialControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Transform.rotate(
                              angle: 3 * 3.1415926535897932 / 2,
                              child: Container(
                                width: controller.value.previewSize!.height,
                                height: controller.value.previewSize!.height,
                                child: CameraPreview(controller),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0, top: 20.0, right: 0.0, bottom: 0.0),
                          child: ElevatedButton(
                            onPressed: _takePicture,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 100),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color: Colors.deepPurple,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: Icon(Icons.camera_alt, size: 30, color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Transform.rotate(
                          angle: 0 * 3.1415926535897932 / 2,
                          child: Container(
//                                  width: controller.value.previewSize!.height,
                            height: 600,
                            child: Image.file(
                              File(imagePath!),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _retakePicture,
                        child: Text('Retake Photo'),
                      ),
                      ElevatedButton(
                        onPressed: _savePhoto,
                        child: Text('Save Photo'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}






// try{
//           final uri = Uri.parse('http://10.0.2.2:3000/scans/upload');
//           final request = http.MultipartRequest ('POST', uri);
//
//           final imageFile = File(imagePath!);
//           final mimeType = lookupMimeType(imagePath!) ?? 'image/jpeg';
//           final imageStream = http.ByteStream(imageFile.openRead());
//           final imageLength = await imageFile.length();
//
//
//           final multipartFile = http.MultipartFile(
//             'image',
//             imageStream,
//             imageLength,
//             filename: path.basename(imagePath!),
//             contentType: MediaType.parse(mimeType),
//           );
//
//           request.files.add(multipartFile);
//           final response = await request.send();
//           print(response);
//
//           print('Uploading file: ${imagePath!}');
//           print('Mime type: $mimeType');
//           print('Response status: ${response.statusCode}');
//           final responseBody = await response.stream.bytesToString();
//           print('Response body: $responseBody');
//
//           if(response.statusCode == 200){
//             ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Photo uploaded successfully!')),
//             );
//           }
//           else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to upload photo.'))
//                 );
//           }
//         }
//         catch (e){
//             ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Error uploading photo: $e')),
//             );
//         }