import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/pages/photos_page.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhotosPage()));
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
        child: Center(
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
                    color: Colors.amber[600],
                    width: 300,
                    height: 400,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        onTapFunc: () {},
                        msgStr: "flip camera",
                        backColor: Colors.grey[600],
                      ),
                      const SizedBox(width: 10),
                      MyButton(
                        onTapFunc: () {},
                        msgStr: "take",
                        backColor: Colors.teal[400],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.openSans(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: 'or, '),
                        TextSpan(
                          text: 'upload a pic',
                          style: TextStyle(
                            color: Colors.teal[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
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


