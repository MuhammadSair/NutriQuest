import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:module_1/navigation_menu.dart';
import 'package:module_1/Screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController =
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
                        Text("Remember Me")
                      ],
                    ),
                    // SizedBox(
                    //   width: 50.0,
                    // ),
                    TextButton(onPressed: () {}, child: Text("forgot password"))
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          // FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: _emailTextController.text,
                          //         password: _passwordTextController.text)
                          //     .then((value) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               const NavigationMenu()));
                          // }).onError((error, stackTrace) {
                          //   print("Error ${error.toString()}");
                          // });
                          Get.to(const NavigationMenu());
                        },
                        child: Text("Sign in"))),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          Get.to(const SignUpScreen());
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String errorMessage = "";
//   final TextEditingController _emailTextController = TextEditingController();
//   final TextEditingController _passwordTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           hexStringToColor("CB2B93"),
//           hexStringToColor("9546C4"),
//           hexStringToColor("5E61F4")
//         ])),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.account_circle, size: 90.0, color: Colors.white),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               reusableTextField("Username or Email", Icons.person_2_outlined,
//                   false, _emailTextController),
//               const SizedBox(
//                 height: 10,
//               ),
//               reusableTextField("Password", Icons.lock_outline, true,
//                   _passwordTextController),
//               const SizedBox(
//                 height: 10,
//               ),
//               showError(),
//               ElevatedButton(
//                 onPressed: () {
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _emailTextController.text,
//                           password: _passwordTextController.text)
//                       .then((value) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const HomePage()));
//                   }).onError((error, stackTrace) {
//                     // print("Error ${error.toString()}");
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       Colors.purple, // Set the background color of the button
//                 ),
//                 child: const Text(
//                   "Login",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               // showError(),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have account?",
//                       style: TextStyle(color: Colors.white70)),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SignUpScreen()));
//                     },
//                     child: const Text(
//                       " Sign Up",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   Widget showError() {
//     return errorMessage.isNotEmpty
//         ? Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               errorMessage,
//               style: const TextStyle(
//                 color: Colors.yellow, // Set the color of the error message
//               ),
//             ),
//           )
//         : Container();
//     // Return an empty container if the error message is empty
//   }

//   Widget removeError() {
//     return Container();
//   }
// }
