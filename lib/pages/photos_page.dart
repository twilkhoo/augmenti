import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotosPage extends StatelessWidget {
  PhotosPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // debugPrint(user.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Transform.translate(
          offset: const Offset(16.0, 14.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'capture',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'id: ${user.uid}',
                    style: GoogleFonts.nanumMyeongjo(
                      color: Colors.grey[400],
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
