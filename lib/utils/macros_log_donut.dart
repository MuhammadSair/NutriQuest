import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_1/utils/base.dart';

class LogsDonut extends StatefulWidget {
  const LogsDonut({Key? key}) : super(key: key);

  @override
  _LogsDonutState createState() => _LogsDonutState();
}

class _LogsDonutState extends State<LogsDonut> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CalorieDataProvider calorieDataProvider = CalorieDataProvider();
  late num baseValue = 0.0;
  Banner? _bannerAd;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

// TODO: Load a banner ad

  Future<void> _initializeData() async {
    await _fetchCarbsData();
  }

  late double sugar = 0;
  late double fiber = 0;
  late double saturatedfats = 0;
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
          // foodCarbs = data['Carbs'] ?? 0;
          sugar = data['Sugar'] ?? 0;
          fiber = data['Fiber'] ?? 0;
          saturatedfats = data['SaturatedFats'] ?? 0;
          // if (kDebugMode) {
          //   print(foodCarbs);
          // } // Default to 0 if 'Calories' is null
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

  Widget _buildColorDot(Color color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
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
                Row(
                  children: [
                    _buildColorDot(Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      "Sugar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    _buildColorDot(Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      "Saturated Fats",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    _buildColorDot(Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "Fiber",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
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
                      value: sugar,
                      color: Colors.blue,
                      radius: 10,
                      showTitle: false
                      // Adjust radius as needed
                      ),
                  PieChartSectionData(
                    value: fiber,
                    color: Colors.pink,
                    radius: 10, // Adjust radius as needed
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: saturatedfats,
                    color: Colors.green,
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
                            // child: Text(
                            //   "${NumberFormat('#,###').format(baseValue - foodCarbs.toInt())} g",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight
                            //           .bold), // Adjust fontSize as needed
                            // ),
                            ),
                        Center(
                          child: Text(
                            "Consumed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight
                                    .bold), // Adjust fontSize as needed
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
