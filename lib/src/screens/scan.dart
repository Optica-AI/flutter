import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optica_app/src/screens/results.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../models/tflite_model.dart';
import '../services/scan_service.dart';
import '../utils/image_processing.dart';
import 'form.dart';

class ScanScreen extends StatefulWidget {
  final VoidCallback onBack;

  ScanScreen({required this.onBack});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? _currentPatientId;
  String? _currentPatientName;
  String? _currentPatientAge;
  String? _currentPatientGender;
  String? _currentPatientDOB;
  late List<CameraDescription> cameras;
  late CameraController controller;
  late Future<void> _initialControllerFuture;
  String? imagePath;
  File? pickedImageFile; // I store the uploaded image here

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      controller = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      _initialControllerFuture = controller.initialize();
      await _initialControllerFuture;
      setState(() {});
      print("Camera initialized successfully");
    } catch (e) {
      print(e);
    }
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
        pickedImageFile = null; // Clear picked image if a new picture is taken
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
      pickedImageFile = null;
    });
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        imagePath = null; // Clear camera image if a new image is picked
      });
    }
  }

  Future<void> _savePhoto() async {
    print('This is the patient ID by diagnosis time: $_currentPatientId');
    File? imageFile = pickedImageFile ?? (imagePath != null ? File(imagePath!) : null);

    if (imageFile != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          });

      try {
        await Future.delayed(const Duration(milliseconds: 3000));

        // Process image
        final preprocessedImage = await preprocessImage(imageFile);

        final isFundus = await isFundusImage(preprocessedImage);

        if (isFundus) {
          // Run diagnosis model if fundus image is the valid.
          final diagnosis = await runInference(preprocessedImage);
          print('This is the diagnosis: $diagnosis');
          print('This is the patient ID by diagnosis time: $_currentPatientId');

          Navigator.of(context).pop();

          // Navigation to diagnosis screen
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
                patientId: _currentPatientId ?? null,
                patientName: _currentPatientName ?? 'N/A',
                patientAge: _currentPatientAge ?? 'N/A',
                patientGender: _currentPatientGender ?? 'N/A',
                patientDOB: _currentPatientDOB ?? 'N/A',
                imagePath: imageFile.path,
                diagnosis: diagnosis,
                timeStamp: DateTime.now().toIso8601String(),
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 1000),
            ),
          );

          print('Once again this is the patientID: $_currentPatientId');
          print('And once again this is the patientDetails: $_currentPatientName');
        } else {
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.deepPurple,
                        size: 60,
                      ),
                      Text(
                        'ERROR',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Flexible(
                        child: Text(
                            "The image is not a valid fundus image. Take or upload a "
                                "fundus image for accurate diagnosis",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('The passed patientid is: $_currentPatientId');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: widget.onBack,
        ),
        title: Text(
          'Scan',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add,
              size: 25,
              color: Colors.deepPurple[900],
            ),
            onPressed: () async {
              final patientDetails = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
              );
              print('This is the received data from forms: $patientDetails');
              if(patientDetails != null){
                setState((){
                  _currentPatientId = patientDetails['patientId'];
                  _currentPatientName = patientDetails['patientName'];
                  _currentPatientAge = patientDetails['patientAge'];
                  _currentPatientGender = patientDetails['patientGender'];
                  _currentPatientDOB = patientDetails['patientDOB'];
                  print('This is the patient IDDDDDD: $_currentPatientId');
                  print('This is the patient Name: $_currentPatientName');
                  print('This is the patient Age: $_currentPatientAge');
                  print('This is the patient Gender: $_currentPatientGender');
                  print('This is the patient DOB: $_currentPatientDOB');

              });
              }
              else{
                print('This is the patient  was not received');
              }
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: pickedImageFile == null && imagePath == null
            ? FutureBuilder<void>(
          future: _initialControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Transform.rotate(
                        angle: 0 * 3.1415926535897932 / 2,
                        child: SizedBox(
                          width: controller.value.previewSize?.height,
                          height: controller.value.previewSize!.width * 1.2 ,
                          child: CameraPreview(controller),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 20.0, right: 0.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding:EdgeInsets.only(left: 20.0,) ,
                            child: ElevatedButton(
                              onPressed: _uploadImage,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 30),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                    color: Colors.deepPurple,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: const Text(
                                '+ Upload',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                          child: ElevatedButton(
                            onPressed: _takePicture,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 100),
                              elevation: 6,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(
                                  color: Colors.deepPurple,
                                  width: 6,
                                ),
                              ),
                            ),
                            child: const Icon(Icons.camera_alt, size: 30, color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Error initializing camera: ${snapshot.error}'),
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
                      height: controller.value.previewSize!.height * 0.2,
                      child: pickedImageFile != null
                          ? Image.file(pickedImageFile!)
                          : Image.file(File(imagePath!)),
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
                  child: const Text('Retake Photo'),
                ),
                ElevatedButton(
                  onPressed: _savePhoto,
                  child: const Text('Diagnose'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
