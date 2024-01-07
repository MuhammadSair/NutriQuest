import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:module_1/Screens/Logins/signup_screen.dart';
import 'package:module_1/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                            Get.to(() => const Navigation());
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                          Navigator.of(context).pop();
                          Get.to(const Navigation());
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Navigation());
                      },
                      child: Text("Continue")),
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
