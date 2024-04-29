import 'package:augmenti/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:augmenti/pages/login_page.dart';
import 'package:augmenti/pages/register_page.dart';

enum Pages {
  landing,
  login,
  register,
}

class LoginOrRegisterOrLandingPage extends StatefulWidget {
  const LoginOrRegisterOrLandingPage({super.key});

  @override
  State<LoginOrRegisterOrLandingPage> createState() =>
      _LoginOrRegisterOrLandingPageState();
}

class _LoginOrRegisterOrLandingPageState
    extends State<LoginOrRegisterOrLandingPage> {
  Pages currPage = Pages.landing;

  Pages curPage = Pages.landing;

  void togglePages(Pages newPage) {
    debugPrint("toggle pages pressed");
    setState(() {
      currPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currPage == Pages.landing) {
      return LandingPage(
        navigateToLogin: () => togglePages(Pages.login),
      );
    } else if (currPage == Pages.login) {
      return LoginPage(
        onGoRegister: () => togglePages(Pages.register),
        onGoLanding: () => togglePages(Pages.landing),
      );
    } else {
      return RegisterPage(
        onGoLogin: () => togglePages(Pages.login),
        onGoLanding: () => togglePages(Pages.landing),
      );
    }
  }
}
