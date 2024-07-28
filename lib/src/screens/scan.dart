import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ScanScreen extends StatefulWidget{
  @override
  _ScanScreenState createState()=> _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>{
  late List<CameraDescription> cameras;
  late CameraController controller;
  late Future<void> _initialControllerFuture;
  String? imagePath;

  @override
  void initState(){
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async{
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high,
    );
    _initialControllerFuture = controller.initialize();
    setState(() {});
  }
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture()async {
    try{
      await _initialControllerFuture;
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = join(directory.path, '${DateTime.now()}.png');
      final image = await controller.takePicture();
      final File savedImage = File(imagePath);

      savedImage.writeAsBytesSync(await image.readAsBytes());
      setState(() {
        this.imagePath = imagePath;
      });
    } catch (e){
      print('Error capturing image:$e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<void>(
              future: _initialControllerFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.value.previewSize!.width,
                        height: controller.value.previewSize!.height,
                        child: CameraPreview(controller),
                      ),
                    ),
                  );
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            if(imagePath != null)
              Image.file(
                File(imagePath!),
                width: 80,
                height: 50,
              ),
            ElevatedButton(
              onPressed: _takePicture,
              child: Text('Capture Image for diagnosis.'),
            ),
          ],
        ),
      )
    );
  }
}