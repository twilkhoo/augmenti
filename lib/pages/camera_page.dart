import 'dart:io';

import 'package:augmenti/components/step1_capture.dart';
import 'package:augmenti/components/step2_augment.dart';
import 'package:augmenti/components/step3_save.dart';
import 'package:augmenti/pages/photos_page.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CameraPages {
  capture,
  augment,
  save,
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<File> imagesList =
      []; // Making it a list to have a single memory location.

  List<File> generatedImages = [];

  final promptController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  CameraPages currPage = CameraPages.capture;

  void togglePages(CameraPages newPage) {
    debugPrint("toggle pages pressed");
    setState(() {
      currPage = newPage;
    });
  }

  Widget _buildPage(BuildContext context, CameraPages page) {
    if (page == CameraPages.capture) {
      return Step1Capture(
        onGoAugment: () => togglePages(CameraPages.augment),
        cameras: widget.cameras,
        imagesList: imagesList,
      );
    } else if (page == CameraPages.augment) {
      return Step2Augment(
        onGoCapture: () => togglePages(CameraPages.capture),
        onGoSave: () => togglePages(CameraPages.save),
        imagesList: imagesList,
        generatedImages: generatedImages,
        promptController: promptController,
      );
    } else {
      return Step3Save(
        onGoCapture: () => togglePages(CameraPages.capture),
        onGoAugment: () => togglePages(CameraPages.augment),
        generatedImages: generatedImages,
        promptController: promptController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Transform.translate(
          offset: const Offset(16.0, 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotosPage(),
                ),
              );
            },
            child: Text(
              'photos',
              style: GoogleFonts.nanumMyeongjo(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.grey[400],
          )
        ],
      ),
      body: SafeArea(
        child: _buildPage(context, currPage),
      ),
    );
  }
}
