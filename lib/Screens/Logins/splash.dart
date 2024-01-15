import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:module_1/Screens/Logins/login_screen%20.dart';
// import 'package:module_1/Screens/home_screen.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   navigateUser();
  // }

  // Future<void> navigateUser() async {
  //   var isLoggedIn = await getLoginStatus();

  //   // Use the Navigator to push the appropriate screen based on the login status
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => isLoggedIn ? Navigation() : LoginScreen(),
  //     ),
  //   );
  // }

  // Future<bool> getLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var status = prefs.getBool('isLoggedIn') ?? false;
  //   return status;
  // }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'images/abblack.png',
      ),
      title: Text(
        'Nutriquest ',
        style: GoogleFonts.bebasNeue(
          color: Colors.blueAccent,
          fontSize: 20,
        ),
      ),
      // backgroundColor: Colors.black,
      showLoader: true,
      loaderColor: Colors.blueAccent,
      navigator: LoginScreen(),
      durationInSeconds: 10,
    );
  }
}
