import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:module_1/navigation_menu.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController =
        TextEditingController();
    final TextEditingController _usenameTextController =
        TextEditingController();
    User? userId = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 24.0, bottom: 24.0, right: 24.0),
          child: Column(children: [
            Form(
                child: Column(
              children: [
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
                          // var password = _passwordTextController.text.trim();
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _emailTextController.text)
                              .then((value) {
                            // print("Created New Account");
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(userId?.uid)
                                .set({
                              'username': username,
                              'email': email,
                              'dateCreated': DateTime.now(),
                              "userId": userId?.uid,
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationMenu()));
                          }).onError((error, stackTrace) {
                            // print("Error ${error.toString()}");
                          });
                        },
                        child: Text("Create account"))),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
