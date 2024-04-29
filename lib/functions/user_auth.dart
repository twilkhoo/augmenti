import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showErrorMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
}

void signUserIn(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) async {
  debugPrint("Sign in clicked.");

  // loading circle
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    showErrorMessage(e.code, context);
  }
}

void signUserUp(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController) async {
  debugPrint("Sign up clicked.");

  // loading circle
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    if (passwordController.text != confirmPasswordController.text) {
      debugPrint("passwords didn't match!");
      Navigator.pop(context);
      showErrorMessage("Passwords don't match!", context);
      return;
    }

    debugPrint("passwords matched!");
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    showErrorMessage(e.code, context);
  }
}
