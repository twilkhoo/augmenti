import 'package:augmenti/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  final Function()? navigateToLogin;
  const LandingPage({super.key, required this.navigateToLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'augmenti',
                    style: GoogleFonts.nanumMyeongjo(
                      color: Colors.grey[400],
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.openSans(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: 'augment your photos with '),
                          TextSpan(
                            text: 'AI ',
                            style: TextStyle(color: Colors.teal[300]),
                          ),
                          const TextSpan(text: 'using '),
                          TextSpan(
                            text: 'stable diffusion 3.1',
                            style: TextStyle(color: Colors.teal[300]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Image.asset(
                    'lib/images/cat.jpg',
                    height: 300,
                  ),
                  const SizedBox(height: 50),
                  MyButton(
                    onTapFunc: navigateToLogin,
                    msgStr: 'login',
                    backColor: Colors.teal[300],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
