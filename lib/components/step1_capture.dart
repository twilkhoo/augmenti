import 'dart:io';

import 'package:augmenti/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:external_path/external_path.dart';

class Step1Capture extends StatefulWidget {
  final Function()? onGoAugment;
  final List<CameraDescription> cameras;
  final List<File> imagesList;

  const Step1Capture({
    super.key,
    required this.onGoAugment,
    required this.cameras,
    required this.imagesList,
  });

  @override
  State<Step1Capture> createState() => _Step1CaptureState();
}

class _Step1CaptureState extends State<Step1Capture> {
  late CameraController cameraController;
  late Future<void> cameraValue;

  bool isRearCamera = true;

  void startCamera(int camera) {
    cameraController = CameraController(
      widget.cameras[camera],
      ResolutionPreset.high,
      enableAudio: false,
    );

    cameraValue = cameraController.initialize();
  }

  @override
  void initState() {
    startCamera(0); // 0 means rear camera.
    super.initState();
  }

  Future _uploadPic() async {
    debugPrint("uploading pic now...");
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      widget.imagesList.add(File(returnedImage!.path));
    });

    widget.onGoAugment;
  }

  Future<File> _savePic(XFile image) async {
    final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}';
    final file = File('$downloadPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (_) {}

    return file;
  }

  void _takePic() async {
    debugPrint("trying to take pic...");

    widget.imagesList.clear();

    XFile? image;
    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }

    image = await cameraController.takePicture();
    final file = await _savePic(image);

    setState(() {
      widget.imagesList.add(file);
    });

    widget.onGoAugment;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.nanumMyeongjo(
                          color: Colors.grey[400],
                          fontSize: 22,
                        ),
                        children: [
                          const TextSpan(text: 'step 1- '),
                          TextSpan(
                            text: 'capture',
                            style: TextStyle(
                              color: Colors.teal[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(10.0),
                // color: Colors.amber[600],
                width: 300,
                height: 400,
                child: FutureBuilder(
                    future: cameraValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: 100,
                          // height: size.height,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: 300,
                              height: 400,
                              child: CameraPreview(cameraController),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    onTapFunc: () {
                      setState(() {
                        isRearCamera = !isRearCamera;
                        isRearCamera ? startCamera(0) : startCamera(1);
                      });
                    },
                    msgStr: "flip camera",
                    backColor: Colors.grey[600],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc: _takePic,
                    msgStr: "take",
                    backColor: Colors.teal[400],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'or,',
                    style: GoogleFonts.openSans(color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: _uploadPic,
                    child: Text(
                      'upload a pic',
                      style: GoogleFonts.openSans(
                        color: Colors.teal[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
