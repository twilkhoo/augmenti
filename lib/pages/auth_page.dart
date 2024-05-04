import 'package:augmenti/pages/camera_page.dart';
import 'package:augmenti/pages/login_or_register_or_landing_page.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const AuthPage({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CameraPage(cameras: cameras); // used to be HomePage()
          } else {
            return const LoginOrRegisterOrLandingPage(); // used to be LoginOrRegisterOrLandingPage()
          }
        },
      ),
    );
  }
}
