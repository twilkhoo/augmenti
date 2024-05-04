import 'package:augmenti/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step1Capture extends StatefulWidget {
  const Step1Capture({super.key});

  @override
  State<Step1Capture> createState() => _Step1CaptureState();
}

class _Step1CaptureState extends State<Step1Capture> {
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
    );
  }
}
