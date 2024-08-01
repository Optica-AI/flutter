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
  final VoidCallback? onBack;

  ScanScreen({this.onBack});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  String? _currentPatientId;
  String? _currentPatientName;
  String? _currentPatientAge;
  String? _currentPatientGender;
  String? _currentPatientDOB;
  List<CameraDescription>? _cameras;
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  String? _imagePath;
  File? _pickedImageFile;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_isInitialized) return;

    try {
      await _initializeControllerFuture;
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, '${DateTime.now()}.jpg');
      final image = await _controller!.takePicture();
      final File savedImage = File(imagePath);

      savedImage.writeAsBytesSync(await image.readAsBytes());
      setState(() {
        _imagePath = imagePath;
        _pickedImageFile = null;
      });

      _controller!.dispose();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  Future<void> _retakePicture() async {
    await _initializeCamera();
    setState(() {
      _imagePath = null;
      _pickedImageFile = null;
    });
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImageFile = File(pickedFile.path);
        _imagePath = null;
      });
    }
  }

  Future<void> _savePhoto() async {
    File? imageFile = _pickedImageFile ?? (_imagePath != null ? File(_imagePath!) : null);

    if (imageFile != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        await Future.delayed(const Duration(milliseconds: 3000));

        final preprocessedImage = await preprocessImage(imageFile);
        final isFundus = await isFundusImage(preprocessedImage);

        if (isFundus) {
          final diagnosis = await runInference(preprocessedImage);

          Navigator.of(context).pop();

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
                patientId: _currentPatientId ?? '',
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
        } else {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
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
            },
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.of(context).pop();
            }
          },
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
              if (patientDetails != null) {
                setState(() {
                  _currentPatientId = patientDetails['patientId'];
                  _currentPatientName = patientDetails['patientName'];
                  _currentPatientAge = patientDetails['patientAge'];
                  _currentPatientGender = patientDetails['patientGender'];
                  _currentPatientDOB = patientDetails['patientDOB'];
                });
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
        child: !_isInitialized
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _pickedImageFile == null && _imagePath == null
            ? Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.62,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Transform.rotate(
                  angle: 0 * 3.1415926535897932 / 2,
                  child: SizedBox(
                    width: _controller?.value.previewSize?.height,
                    height: _controller?.value.previewSize!.width ?? 0 * 1.2,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'pickImage',
                    onPressed: _uploadImage,
                    tooltip: 'Pick Image from gallery',
                    child: const Icon(Icons.photo_library),
                  ),
                  FloatingActionButton(
                    heroTag: 'takePicture',
                    onPressed: _takePicture,
                    tooltip: 'Capture Image',
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _pickedImageFile != null
                        ? FileImage(_pickedImageFile!)
                        : FileImage(File(_imagePath!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    heroTag: 'retakeImage',
                    onPressed: _retakePicture,
                    tooltip: 'Retake Image',
                    child: const Icon(Icons.camera_alt),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: FloatingActionButton(
                      heroTag: 'Diagnose',
                      onPressed: _savePhoto,
                      tooltip: 'Run Diagnosis',
                      child: Text(
                        'Diagnose',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
