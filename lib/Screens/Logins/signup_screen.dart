import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:module_1/Screens/base_finder/main.dart';
import 'package:module_1/navigation.dart';

import 'package:module_1/navigation_menu.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController =
        TextEditingController();
    final TextEditingController _usenameTextController =
        TextEditingController();
    User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 24.0, bottom: 24.0, right: 24.0),
          child: Center(
            child: Column(children: [
              Form(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 256.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: "Username",
                    ),
                    controller: _usenameTextController,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_2_outlined),
                        labelText: "E-mail"),
                    controller: _emailTextController,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        suffixIcon: Icon(Iconsax.eye_slash),
                        labelText: "Password"),
                    controller: _passwordTextController,
                  ),
                  // SizedBox(
                  //   width: 50.0,
                  // ),

                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            var username = _usenameTextController.text.trim();
                            var email = _emailTextController.text.trim();
                            var password = _passwordTextController.text.trim();
                            // var password = _passwordTextController.text.trim();
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            )
                                .then((value) {
                              // print("Created New Account");
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(currentUser?.uid)
                                  .set({
                                'username': username,
                                'email': email,
                                'dateCreated': DateTime.now(),
                                "currentUser": currentUser!.uid,
                              });
                              Get.offAll(() => NavigationMenu());
                            }).onError((error, stackTrace) {
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
                              // print("Error ${error.toString()}");
                            });
                          },
                          child: Text("Create account"))),
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
