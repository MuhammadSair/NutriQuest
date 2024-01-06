import 'package:flutter/material.dart';
import 'package:module_1/Screens/logins_original/login.dart';
import 'package:module_1/Screens/logins_original/singup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreens() {
    print("Toggling Screen");
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        showSignUpPage: toggleScreens,
      );
    } else {
      return SignUp(
        showLoginPage: toggleScreens,
      );
    }
  }
}
