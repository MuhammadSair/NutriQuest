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
  String activityLevel = 'level_1';
  int age = 12;
  int weight = 12;
  int height = 82;
  String goal = "weightGain";
  // Text controllers
  TextEditingController genderController = TextEditingController();
  TextEditingController activityLevelController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  @override
  void dispose() {
    // Dispose the text controllers
    genderController.dispose();
    activityLevelController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call Example'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              // Your UI components here
              TextField(
                controller: genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: activityLevelController,
                decoration: InputDecoration(labelText: 'Activity Level'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height'),
              ),
              TextField(
                controller: goalController,
                decoration: InputDecoration(labelText: 'goal'),
              ),
              ElevatedButton(
                onPressed: () async {
                  gender = genderController.text;
                  activityLevel = activityLevelController.text;
                  goal = goalController.text;
                  age = int.tryParse(ageController.text) ?? 0;
                  weight = int.tryParse(weightController.text) ?? 0;
                  height = int.tryParse(heightController.text) ?? 0;

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyWidget(
                  //       gender: gender,
                  //       activityLevel: activityLevel,
                  //       age: age,
                  //       weight: weight,
                  //       height: height,
                  //     ),
                  //   ),
                  // );
                  await dataProcessor.processAndStoreInFirestore(
                    gender: gender,
                    activityLevel: activityLevel,
                    age: age,
                    weight: weight,
                    height: height,
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("goal", goal);
                  dataProcessor.goal(goal);
                  Get.offAll(() => NavigationMenu());
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
