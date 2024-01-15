import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:module_1/Screens/base_finder/base_giver.dart';
// import 'package:flutter_any_logo/flutter_any_logo.dart';
// import 'package:module_1/Screens/food_log.dart';

class CalorieDonutChart extends StatefulWidget {
  const CalorieDonutChart({super.key});

  @override
  _CalorieDonutChartState createState() => _CalorieDonutChartState();
}

class _CalorieDonutChartState extends State<CalorieDonutChart> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  FitnessDataProcessor dataProcessor = FitnessDataProcessor();
  late String goal;
  late Map<String, dynamic> prefs;
  late double foodCalorie = 0;
  late double base = 0;
  @override
  void initState() {
    super.initState();
    // Fetch calorie data from Firestore when the widget is initialized
    _fetchCalorieData();

    // Fetch goal data from Firestore when the widget is initialized
    _fetchGoalData().then((_) {
      // After fetching the goal data, fetch the calorie and base data
      _fetchCalorieData();
      _fetchBaseData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fetchCalorieData();
  }

  Future<void> _fetchGoalData() async {
    // Assuming you have a collection named 'Nutrition' in F.0000000000000000irestore
    // and each document contains a 'Calories' field
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('goal')
          .where('userId',
              isEqualTo: currentUser!.uid) // Adjust this query accordingly
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use the first document for simplicity, you may adjust this based on your data model
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          goal = data['goal'];
          if (kDebugMode) {
            print("Goal value is $goal");
          } // Default to 0 if 'Calories' is null
        });
      } else {
        // Handle case where no data is found
        print('No data found in goal Firestore.');
        goal = 'MaintainWeight';
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data from Firestore: $error');
    }
  }

  Future<void> _fetchCalorieData() async {
    // Assuming you have a collection named 'Nutrition' in F.0000000000000000irestore
    // and each document contains a 'Calories' field
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Nutrition')
          .where('userId',
              isEqualTo: currentUser!.uid) // Adjust this query accordingly
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use the first document for simplicity, you may adjust this based on your data model
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          foodCalorie = data['Calories'] ?? 0;
          if (kDebugMode) {
            print(foodCalorie);
          } // Default to 0 if 'Calories' is null
        });
      } else {
        // Handle case where no data is found
        print('No data found in Calorie Firestore.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data from Firestore: $error');
    }
  }

  Future<void> _fetchBaseData() async {
    // Assuming you have a collection named 'Nutrition' in F.0000000000000000irestore
    // and each document contains a 'Calories' field
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('fitnessData')
          // .where('userId',
          //     isEqualTo: currentUser!.uid) // Adjust this query accordingly
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use the first document for simplicity, you may adjust this based on your data model
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          switch (goal) {
            case 'MaintainWeight':
              base = data[
                  'MaintainWeightCalory']; // Set the base calorie for MaintainWeight
              break;
            case 'MildWeightLoss':
              base = data[
                  'MildWeightLossCalory']; // Set the base calorie for MildWeightLoss
              break;
            case 'WeightLoss':
              base = data[
                  'WeightLossCalory']; // Set the base calorie for WeightLoss
              break;
            case 'ExtremeWeightGain':
              base = data[
                  'ExtremeWeightGainCalory']; // Set the base calorie for ExtremeWeightGain
              break;
            case 'WeightGain':
              base = data[
                  'WeightGainCalory']; // Set the base calorie for ExtremeWeightGain
              break;
            // Add more cases for other goals if needed
            // default:
            //   base = 2500;
            // Default base calorie
          } // Default to 0 if 'Calories' is null
        });
        if (kDebugMode) {
          print("Base Value is $base");
        }
      } else {
        // Handle case where no data is found
        print('No data found in Base Firestore.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Base Error fetching data from Firestore: $error');
    }
  }

  // dynamic calorie = foodLogInstance.currentState.foodCalorieValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust elevation as needed
      margin: const EdgeInsets.all(16.0), // Adjust margin as needed
      child: SizedBox(
        height: 200, // Adjust height as needed
        child: Stack(
          children: [
            Column(
              children: [
                Text("Current Calories="),
                SizedBox(
                  height: 5,
                ),
                Text("Base - Total="),
                Icon(Icons.emoji_food_beverage_outlined)
              ],
            ),
            PieChart(
              PieChartData(
                startDegreeOffset: 270,
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                // Adjust radius as needed
                sections: [
                  PieChartSectionData(
                    value: foodCalorie,
                    color: Colors.blueAccent,
                    radius: 10, // Adjust radius as needed
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: (base - foodCalorie),
                    color: Colors.grey,
                    radius: 10,
                    showTitle: false,

                    // Adjust radius as needed
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80, // Adjust height as needed
                    width: 80, // Adjust width as needed
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5.0, // Adjust blurRadius as needed
                          spreadRadius: 5.0, // Adjust spreadRadius as needed
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            '${NumberFormat('#,###').format(base - foodCalorie.toInt())} Kcal',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight
                                    .bold), // Adjust fontSize as needed
                          ),
                        ),
                        Center(
                          child: Text(
                            (base - foodCalorie) > 0 ? 'Remaining' : 'Over',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12), // Adjust fontSize as needed
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// void setBaseCalorie(String goal) {
  //   // setState(() {
  //   switch (goal) {
  //     case 'MaintainWeight':
  //       base = prefs[
  //           'MaintainWeightCalory']; // Set the base calorie for MaintainWeight
  //       break;
  //     case 'MildWeightLoss':
  //       base = prefs[
  //           'MildWeightLossCalory']; // Set the base calorie for MildWeightLoss
  //       break;
  //     case 'WeightLoss':
  //       base = prefs['WeightLossCalory']; // Set the base calorie for WeightLoss
  //       break;
  //     case 'ExtremeWeightGain':
  //       base = prefs[
  //           'ExtremeWeightGainCalory']; // Set the base calorie for ExtremeWeightGain
  //       break;
  //     // Add more cases for other goals if needed
  //     // default:
  //     //   base = 2500; // Default base calorie
  //   }
  //   // });
  //   if (kDebugMode) {
  //     print("Base value is $base");
  //   }
  // }
      // getPrefs().then((value) {
    //   prefs = value;
    //   goal =
    //       prefs['goal'] ?? ''; // Retrieve the goal value from SharedPreferences
    //   setBaseCalorie(goal);
    // });
  // Future<Map<String, dynamic>> getPrefs() async {
  //   return dataProcessor.getPrefs();
  // }

  // FoodLog foodLogInstance = FoodLog();
