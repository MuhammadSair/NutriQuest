import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:module_1/Screens/base_finder/base_giver.dart';
import 'package:module_1/navigation.dart';
import 'package:module_1/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'display.dart';

class BaseFinder extends StatefulWidget {
  @override
  _BaseFinderState createState() => _BaseFinderState();
}

class _BaseFinderState extends State<BaseFinder> {
  final ApiService apiService = ApiService();
  FitnessDataProcessor dataProcessor = FitnessDataProcessor();

  String gender = 'female';
  String activityLevel = 'level_1'; // Default value
  String activityIntensity = 'low Activity';
  String goal = "WeightGain";

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildTextField('Age in years', ageController),
            buildTextField('Weight in kg', weightController),
            buildTextField('Height in cm', heightController),
            Text('Select Gender',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildGenderSelection(),
            Text('Your Workout Intensity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildActivityLevelDropdown(),
            Text('Goal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildGoalDropdown(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  int age = int.tryParse(ageController.text) ?? 0;
                  int weight = int.tryParse(weightController.text) ?? 0;
                  int height = int.tryParse(heightController.text) ?? 0;

                  await dataProcessor.processAndStoreInFirestore(
                    gender: gender,
                    activityLevel: activityLevel,
                    age: age,
                    weight: weight,
                    height: height,
                  );

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("age", ageController.text);
                  prefs.setString("height", heightController.text);
                  prefs.setString("weight", weightController.text);

                  dataProcessor.goal(goal);

                  Get.offAll(() => NavigationMenu());
                },
                child: Text('Get Your Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 250.0,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: label),
          ),
        ),
      ),
    );
  }

  Widget buildGenderSelection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200.0,
              child: ListTile(
                tileColor: gender == 'male' ? Colors.blue : null,
                title: Text(
                  'Male',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    gender = 'male';
                  });
                },
              ),
            ),
            SizedBox(
              width: 200.0,
              child: ListTile(
                tileColor: gender == 'female' ? Colors.blue : null,
                title: Text(
                  'Female',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    gender = 'female';
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityLevelDropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: activityIntensity,
              items: ['low Activity', 'Moderate Activity', 'High Activity']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue == 'Moderate Activity') {
                    activityLevel = 'level_2';
                  } else if (newValue == 'High Activity') {
                    activityLevel = 'level_3';
                  } else {
                    activityLevel = 'level_1';
                  }
                  activityIntensity = newValue ?? 'Low Activity';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGoalDropdown() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: goal,
              items: [
                'WeightLoss',
                'WeightGain',
                'MildWeightLoss',
                'MildWeightGain',
                'MaintainWeight',
                'ExtremeWeightLoss',
                'ExtremeWeightGain',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  goal = newValue ?? goal;
                });
              },
              hint: Text('Select Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:module_1/Screens/base_finder/base_giver.dart';
// import 'package:module_1/navigation.dart';
// import 'package:module_1/navigation_menu.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'api_service.dart';
// import 'display.dart';

// class BaseFinder extends StatefulWidget {
//   @override
//   _BaseFinderState createState() => _BaseFinderState();
// }

// class _BaseFinderState extends State<BaseFinder> {
//   final ApiService apiService = ApiService();
//   FitnessDataProcessor dataProcessor = FitnessDataProcessor();

//   String gender = 'female';
//   String activityLevel = 'level_1';
//   String goal = "weightGain";

//   TextEditingController ageController = TextEditingController();
//   TextEditingController weightController = TextEditingController();
//   TextEditingController heightController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController activitylevelController = TextEditingController();
//   TextEditingController goalController = TextEditingController();

//   @override
//   void dispose() {
//     ageController.dispose();
//     weightController.dispose();
//     heightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About You'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Column(
//             //   children: [
//             //     Text('Select Gender'),
//             //     ListTile(
//             //       title: const Text('Male'),
//             //       leading: Radio<String>(
//             //         value: 'male',
//             //         groupValue: gender,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             gender = value ?? gender;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('Female'),
//             //       leading: Radio<String>(
//             //         value: 'female',
//             //         groupValue: gender,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             gender = value ?? gender;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             // Text('Select Activity Level'),
//             // DropdownButton<String>(
//             //   value: activityLevel,
//             //   items:
//             //       List<String>.generate(7, (int index) => 'level_${index + 1}')
//             //           .map<DropdownMenuItem<String>>((String value) {
//             //     return DropdownMenuItem<String>(
//             //       value: value,
//             //       child: Text(value),
//             //     );
//             //   }).toList(),
//             //   onChanged: (String? newValue) {
//             //     setState(() {
//             //       activityLevel = newValue ?? activityLevel;
//             //     });
//             //   },
//             //   hint: Text('Select Activity Level'),
//             // ),
//             TextField(
//               controller: ageController,
//               decoration: InputDecoration(labelText: 'Age in years'),
//             ),
//             TextField(
//               controller: weightController,
//               decoration: InputDecoration(labelText: 'Weight in kg'),
//             ),
//             TextField(
//               controller: heightController,
//               decoration: InputDecoration(labelText: 'Height in cm'),
//             ),
//             TextField(
//               controller: genderController,
//               decoration: InputDecoration(labelText: 'Gender'),
//             ),
//             TextField(
//               controller: activitylevelController,
//               decoration: InputDecoration(labelText: 'activity_level'),
//             ),
//             TextField(
//               controller: goalController,
//               decoration: InputDecoration(labelText: 'goal'),
//             ),
//             Text('Select your goal'),
//             // Column(
//             //   children: [
//             //     ListTile(
//             //       title: const Text('ExtremeWeightGain'),
//             //       leading: Radio<String>(
//             //         value: 'ExtremeWeightGain',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('ExtremeWeightLoss'),
//             //       leading: Radio<String>(
//             //         value: 'ExtremeWeightLoss',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('MaintainWeight'),
//             //       leading: Radio<String>(
//             //         value: 'MaintainWeight',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('MildWeightGain'),
//             //       leading: Radio<String>(
//             //         value: 'MildWeightGain',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('MildWeightLoss'),
//             //       leading: Radio<String>(
//             //         value: 'MildWeightLoss',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('WeightGain'),
//             //       leading: Radio<String>(
//             //         value: 'WeightGain',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //     ListTile(
//             //       title: const Text('WeightLoss'),
//             //       leading: Radio<String>(
//             //         value: 'WeightLoss',
//             //         groupValue: goal,
//             //         onChanged: (String? value) {
//             //           setState(() {
//             //             goal = value ?? goal;
//             //           });
//             //         },
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   int age = int.tryParse(ageController.text) ?? 0;
//                   int weight = int.tryParse(weightController.text) ?? 0;
//                   int height = int.tryParse(heightController.text) ?? 0;
//                   gender = genderController.text;
//                   activityLevel = activitylevelController.text;
//                   goal = goalController.text;

//                   await dataProcessor.processAndStoreInFirestore(
//                     gender: gender,
//                     activityLevel: activityLevel,
//                     age: age,
//                     weight: weight,
//                     height: height,
//                   );
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   prefs.setString("age", ageController.text);
//                   prefs.setString("height", heightController.text);
//                   prefs.setString("weight", weightController.text);
//                   dataProcessor.goal(goal);
//                   Get.offAll(() => Navigation());
//                 },
//                 child: Text('Get Your Plan'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
