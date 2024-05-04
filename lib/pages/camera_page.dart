import 'package:augmenti/components/my_button.dart';
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
  // late CameraController cameraController;
  // late Future<void> cameraValue;

  // void startCamera(int camera) {
  //   cameraController = CameraController(
  //     widget.cameras[camera],
  //     ResolutionPreset.high,
  //     enableAudio: false,
  //   );

  //   cameraValue = cameraController.initialize();
  // }

  // @override
  // void initState() {
  //   startCamera(0); // 0 means rear camera.
  //   super.initState();
  // }

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

  void onUploadPic() {
    debugPrint("uploading pic now...");
  }

  Widget _buildPage(BuildContext context, CameraPages page) {
    if (page == CameraPages.capture) {
      return Step1Capture(
        onGoAugment: () => togglePages(CameraPages.augment),
        onUploadPic: onUploadPic,
      );
    } else if (page == CameraPages.augment) {
      return Step2Augment(
        onGoCapture: () => togglePages(CameraPages.capture),
        onGoSave: () => togglePages(CameraPages.save),
      );
    } else {
      return Step3Save(
        onGoCapture: () => togglePages(CameraPages.capture),
        onGoAugment: () => togglePages(CameraPages.augment),
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








        // child: FutureBuilder(
        //     future: cameraValue,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         return SizedBox(
        //           width: 100,
        //           // height: size.height,
        //           child: FittedBox(
        //             fit: BoxFit.cover,
        //             child: SizedBox(
        //               width: 300,
        //               child: CameraPreview(cameraController),
        //             ),
        //           ),
        //         );
        //       } else {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     }),


