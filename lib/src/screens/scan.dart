import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
                        ElevatedButton(
                          onPressed: _takePicture,
                          child: Text('Take Photo'),
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
                    child: Transform.rotate(
                        angle: 3 * 3.14159265 / 2,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.file(
                                File(imagePath!),
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
                        onPressed: () {
                          // Handle saving the image
                        },
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
