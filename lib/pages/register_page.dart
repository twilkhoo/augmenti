import 'package:augmenti/components/my_button.dart';
import 'package:augmenti/components/my_textfield.dart';
import 'package:augmenti/components/square_tile.dart';
import 'package:augmenti/functions/user_auth.dart';
import 'package:augmenti/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onGoLogin;
  final Function()? onGoLanding;
  const RegisterPage(
      {super.key, required this.onGoLogin, required this.onGoLanding});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          leading: IconButton(
            onPressed: () {
              widget.onGoLanding!();
            },
            icon: Icon(
              Icons.home,
              color: Colors.grey[600],
              size: 30,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          ),
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
                      'augmenti',
                      style: GoogleFonts.nanumMyeongjo(
                        color: Colors.grey[400],
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 25),

                    Text(
                      'Join now!',
                      style: GoogleFonts.openSans(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 25),

                    MyTextField(
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'confirm password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.openSans(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    MyButton(
                      msgStr: 'sign in',
                      onTapFunc: () {
                        signUserUp(context, emailController, passwordController,
                            confirmPasswordController);
                      },
                      backColor: Colors.teal[300],
                    ),

                    const SizedBox(height: 50),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[700],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Or continue with',
                            style:
                                GoogleFonts.openSans(color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[700],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 25),

                    // google and apple sign in button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: 'lib/images/google.png',
                        ),
                        const SizedBox(width: 10),
                        SquareTile(
                          onTap: () {},
                          imagePath: 'lib/images/apple.png',
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // not a member? register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.openSans(color: Colors.grey[500]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onGoLogin,
                          child: Text(
                            'Join now',
                            style: GoogleFonts.openSans(
                              color: Colors.teal[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
