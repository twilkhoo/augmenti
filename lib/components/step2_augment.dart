import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step2Augment extends StatefulWidget {
  const Step2Augment({super.key});

  @override
  State<Step2Augment> createState() => _Step2AugmentState();
}

class _Step2AugmentState extends State<Step2Augment> {
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
                          const TextSpan(text: 'step 2- '),
                          TextSpan(
                            text: 'augment',
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
              Slider(
                value: _currentBrushWidth,
                max: 100,
                min: 1,
                // divisions: 5,
                label: _currentBrushWidth.round().toString(),
                activeColor: Colors.white,
                inactiveColor: Colors.grey[400],
                onChanged: (double value) {
                  setState(() {
                    _currentBrushWidth = value;
                  });
                },
              ),
              MyTextField(
                controller: promptController,
                hintText: "enter a prompt",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyButton(
                onTapFunc: () {},
                backColor: Colors.teal[400],
                msgStr: "augment",
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
                      text: 'go back',
                      style: TextStyle(
                        color: Colors.teal[300],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
