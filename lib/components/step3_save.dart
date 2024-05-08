// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/components/my_textfield.dart';
import 'package:augmenti/functions/user_auth.dart';
import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Step3Save extends StatefulWidget {
  final Function()? onGoCapture;
  final Function()? onGoAugment;
  final List<File> generatedImages;
  final TextEditingController promptController;

  const Step3Save({
    super.key,
    required this.onGoCapture,
    required this.onGoAugment,
    required this.generatedImages,
    required this.promptController,
  });

  @override
  State<Step3Save> createState() => _Step3SaveState();
}

class _Step3SaveState extends State<Step3Save> {
  final promptController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;


  Future<void> _savePicToDevice(XFile image) async {
    final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}';
    final file = File('$downloadPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (_) {}
  }

  Future<void> _uploadPicToGCS(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref();

    // Every user gets their own folder.
    final currPicRef = storageRef.child('${user.uid}/${DateTime.now().millisecondsSinceEpoch}');

    // Upload image first.
    try {
      await currPicRef.putFile(image);
    } on firebase_core.FirebaseException catch (e) {
      showErrorMessage(message: e, context: context);
    }

    // Upload the corresponding prompt as a string with the same name (different file extension)
    try {
      String appendedPromptString = 'data:text/plain;base64,' + $promptController.text

      await currPicRef.putString(appendedPromptString, format: PutStringFormat.dataUrl);
    } on firebase_core.FirebaseException catch (e) {
      showErrorMessage(message: e, context: context);
    }
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
                          const TextSpan(text: 'step 3- '),
                          TextSpan(
                            text: 'save',
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
                color: Colors.teal[600],
                width: 300,
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    onTapFunc: () async {
                      await _uploadPicToGCS(widget.generatedImages[0]);
                    },
                    msgStr: "save",
                    backColor: Colors.teal[400],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc: () async {
                      await _savePicToDevice(widget.generatedImages[0]);
                    },
                    msgStr: "download",
                    backColor: Colors.teal[400],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc:
                        widget.onGoAugment, // most recent state is saved.
                    msgStr: "edit",
                    backColor: Colors.teal[400],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc: widget.onGoCapture, // overwrites latest pic.
                    msgStr: "capture",
                    backColor: Colors.teal[400],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "turn the building into a cartoon pineapple",
                style: GoogleFonts.nanumMyeongjo(
                  fontSize: 22,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
