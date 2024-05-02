import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:module_1/Screens/base_finder/base_giver.dart';
import 'package:module_1/utils/base.dart';
// import 'package:flutter_any_logo/flutter_any_logo.dart';
// import 'package:module_1/Screens/food_log.dart';

class CalorieDonutChart extends StatefulWidget {
  const CalorieDonutChart({super.key});

  @override
  _CalorieDonutChartState createState() => _CalorieDonutChartState();
}

class _CalorieDonutChartState extends State<CalorieDonutChart> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  CalorieDataProvider calorieDataProvider = CalorieDataProvider();
  late String goal;
  late Map<String, dynamic> prefs;
  late double foodCalorie = 0;
  // late double base = 0;
  late num baseValue = 0.0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchData();
    await _fetchCalorieData();
  }

  Future<void> _fetchData() async {
    try {
      await calorieDataProvider.fetchData();

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          baseValue = calorieDataProvider.getBaseValue();
          // baseValue *= 0.50;
          if (kDebugMode) {
            print("Base value of carbs is $baseValue");
          }
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 5, // Adjust elevation as needed
      margin: const EdgeInsets.all(16.0), // Adjust margin as needed
      child: SizedBox(
        height: 200, // Adjust height as needed
        child: Stack(
          children: [
            Column(
              children: [
                // Text("Current Calories="),
                SizedBox(
                  height: 10,
                  width: 50,
                ),
                // Text("Base - Total="),
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
                    color: const Color.fromARGB(255, 255, 230, 0),
                    radius: 10, // Adjust radius as needed
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: (baseValue - foodCalorie),
                    color: Colors.white,
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
                          color: Colors.transparent,
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
                            '${NumberFormat('#,###').format(baseValue - foodCalorie.toInt())} Kcal',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight
                                    .bold), // Adjust fontSize as needed
                          ),
                        ),
                        Center(
                          child: Text(
                            (baseValue - foodCalorie) > 0
                                ? 'Remaining'
                                : 'Over',
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
