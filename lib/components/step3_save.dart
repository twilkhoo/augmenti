import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step3Save extends StatefulWidget {
  const Step3Save({super.key});

  @override
  State<Step3Save> createState() => _Step3SaveState();
}

class _Step3SaveState extends State<Step3Save> {
  double _currentBrushWidth = 20;
  final promptController = TextEditingController();

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
                    onTapFunc: () {},
                    msgStr: "save",
                    backColor: Colors.teal[400],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc: () {},
                    msgStr: "download",
                    backColor: Colors.teal[400],
                  ),
                  const SizedBox(width: 10),
                  MyButton(
                    onTapFunc: () {},
                    msgStr: "edit",
                    backColor: Colors.teal[400],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "insert prompt here",
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
