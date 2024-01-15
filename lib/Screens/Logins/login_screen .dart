import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:module_1/Screens/Logins/signup_screen.dart';
import 'package:module_1/Screens/base_finder/main.dart';

import 'package:module_1/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  void dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SpinKitCubeGrid(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.white,
                ),
              );
            },
            size: 50,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // User? currentUser = FirebaseAuth.instance.currentUser;
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 24.0, bottom: 24.0, right: 24.0),
          child: Column(children: [
            // const Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [Image(image: AssetImage("assetName"))],
            // ),
            const SizedBox(
              height: 200.0,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: "E-Mail",
                  ),
                  controller: emailTextController,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: Icon(Iconsax.eye_slash),
                      labelText: "Password"),
                  controller: passwordTextController,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Text("Remember Me")
                      ],
                    ),
                    // SizedBox(
                    //   width: 50.0,
                    // ),
                    TextButton(
                        onPressed: () {}, child: const Text("forgot password"))
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          var email = emailTextController.text.trim();
                          var password = passwordTextController.text.trim();
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("isLoggedIn", true);

                            Get.offAll(() =>BaseFinder() );
                          }).onError((error, stackTrace) {
                            // print("Error ${error.toString()}");
                            // Navigator.of(context).pop();
                            // print(e);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: error.toString(),
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                              dismissOnTouchOutside: true,
                            ).show();
                          });

                          // Get.to(const NavigationMenu());
                        },
                        child: Text("Sign in"))),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                        child: Text("Create account"))),
                const SizedBox(
                  height: 16.0,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         Get.to(const NavigationMenu());
                //       },
                //       child: Text("Continue")),
                // )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
