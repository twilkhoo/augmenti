import 'dart:io';
import 'dart:ui';

import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/components/my_textfield.dart';
import 'package:augmenti/functions/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:stability_sdk/stability_sdk.dart';

class Step2Augment extends StatefulWidget {
  final Function()? onGoCapture;
  final Function()? onGoSave;
  final List<File> imagesList;
  final List<File> generatedImages;
  final TextEditingController promptController;

  const Step2Augment({
    super.key,
    required this.onGoCapture,
    required this.onGoSave,
    required this.imagesList,
    required this.generatedImages,
    required this.promptController,
  });

  @override
  State<Step2Augment> createState() => _Step2AugmentState();
}

class _Step2AugmentState extends State<Step2Augment> {
  double _currentBrushWidth = 20;
  StabilityApiClient client;

  // https://pub.dev/documentation/image/latest/image/gaussianBlur.html
  Image gaussianBlur(Image src,
      {required int radius,
      Image? mask,
      Channel maskChannel = Channel.luminance}) {
    if (radius <= 0) {
      return src;
    }

    SeparableKernel kernel;

    if (_gaussianKernelCache.containsKey(radius)) {
      kernel = _gaussianKernelCache[radius]!;
    } else {
      // Compute coefficients
      final num sigma = radius * (2.0 / 3.0);
      final num s = 2.0 * sigma * sigma;

      kernel = SeparableKernel(radius);

      num sum = 0.0;
      for (var x = -radius; x <= radius; ++x) {
        final num c = exp(-(x * x) / s);
        sum += c;
        kernel[x + radius] = c;
      }
      // Normalize the coefficients
      kernel.scaleCoefficients(1.0 / sum);

      // Cache the kernel for this radius so we don't have to recompute it
      // next time.
      _gaussianKernelCache[radius] = kernel;
    }

    return separableConvolution(src,
        kernel: kernel, mask: mask, maskChannel: maskChannel);
  }

  // The main inpainting execution, which throws an exception if any error occurs.
  void inpaint(File image, Image mask) {
    setState(() {
      isLoading = true;
      image = null;
    });

    final request = RequestBuilder(promptController)
        .setEngineType(EngineType.inpainting_v2_0)
        .setSampleCount(1)
        .setImage(image)
        .setMask(mask)
        .build();

    client.generate(request).listen((answer) {
      if (answer.artifacts?.isNotEmpty == true) {
        setState(() {
          widget.generatedImages.add(answer.artifacts?.first.getImage());
          isLoading = false;
        });
        widget.onGoSave;
      }
    });
  }

  // Note, we must handle cases of images too large later.
  void generateImage() {
    // Export mask.
    final maskBytes = augmentController.toPngBytes();

    final codec = await instantiateImageCodec(maskBytes);
    final frameInfo = await codec.getNextFrame();
    final mask = frameInfo.image;

    // Gaussian blur the mask, the params were experimentally determined (we 
    // could possibly have this as user selections later?).
    final blurredMask = gaussianBlur(radius: 5, mask: mask);
    
    // Send picture and mask to Inpainting model, catch errors.
    try {
      inpaint(widget.imagesList[0], blurredMask);
    } catch(e) {
      showErrorMessage(message: e, context: context);
    }
  }

  SignatureController augmentController = SignatureController(
    penStrokeWidth: _currentBrushWidth * 10,
    penColor: Colors.grey[200],
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    isLoading = false;
    client = StabilityApiClient.init(dotenv.get('STABILITY_API_KEY'));
  }

  @override
  void dispose() {
    augmentController.dispose();
    super.dispose();
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
              Stack(children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  // color: Colors.teal[600],
                  width: 300,
                  height: 400,
                  child: Image(
                    image: FileImage(File(widget.imagesList[0].path)),
                  ),
                ),
                Signature(
                  controller: augmentController,
                  width: 300,
                  height: 300,
                  opacity: 0.5,
                ),
              ]),
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
                controller: widget.promptController,
                hintText: "enter a prompt",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyButton(
                onTapFunc: widget.onGoSave,
                backColor: Colors.teal[400],
                msgStr: "augment",
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'or,',
                    style: GoogleFonts.openSans(color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onGoCapture,
                    child: Text(
                      'go back',
                      style: GoogleFonts.openSans(
                        color: Colors.teal[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoading) const CircularProgressIndicator(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
