import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_1/utils/base.dart';

class CarbsDonutChart extends StatefulWidget {
  const CarbsDonutChart({Key? key}) : super(key: key);

  @override
  _CarbsDonutChartState createState() => _CarbsDonutChartState();
}

class _CarbsDonutChartState extends State<CarbsDonutChart> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CalorieDataProvider calorieDataProvider = CalorieDataProvider();
  late num baseValue = 0.0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchData();
    await _fetchCarbsData();
  }

  Future<void> _fetchData() async {
    try {
      await calorieDataProvider.fetchData();

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          baseValue = calorieDataProvider.getBaseValue();
          baseValue *= 0.50;
          if (kDebugMode) {
            print("Base value of carbs is $baseValue");
          }
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch calorie data from Firestore when the widget is initialized
  //   _fetchCarbsData();
  //   calorieDataProvider.fetchData().then((value) => setState(() {
  //         baseValue = calorieDataProvider.getBaseValue();
  //         baseValue *= 0.50;
  //         // baseValue != baseValue;
  //         if (kDebugMode) {
  //           print("Base value of carbs is $baseValue");
  //         }
  //       }));
  // }

  // num getBaseValue() {
  //   return calorieDataProvider.getBaseValue();
  // }

  late double foodCarbs = 0;
  // late var baseValue = 0.0;
  Future<void> _fetchCarbsData() async {
    // Assuming you have a collection named 'Nutrition' in Firestore
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
          foodCarbs = data['Carbs'] ?? 0;
          if (kDebugMode) {
            print(foodCarbs);
          } // Default to 0 if 'Calories' is null
        });
      } else {
        // Handle case where no data is found
        print('No data found in Firestore.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data from Firestore: $error');
    }
  }

  Widget build(BuildContext context) {
    return Card(
      // color: Colors.blue,
      elevation: 5, // Adjust elevation as needed
      margin: const EdgeInsets.all(16.0), // Adjust margin as needed
      child: SizedBox(
        height: 150, // Adjust height as needed
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                  width: 20.0,
                ),
                Text(
                  " Carbs",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                // Text("Base - Total="),
                // Icon(Icons.emoji_food_beverage_outlined)
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
                      value: foodCarbs,
                      color: const Color.fromARGB(255, 255, 230, 0),
                      radius: 10,
                      showTitle: false
                      // Adjust radius as needed
                      ),
                  PieChartSectionData(
                    value: (baseValue.toDouble() - foodCarbs),
                    color: Colors.white,
                    radius: 10, // Adjust radius as needed
                    showTitle: false,
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
                            "${NumberFormat('#,###').format(baseValue - foodCarbs.toInt())} g",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight
                                    .bold), // Adjust fontSize as needed
                          ),
                        ),
                        Center(
                          child: Text(
                            "Remainings",
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
