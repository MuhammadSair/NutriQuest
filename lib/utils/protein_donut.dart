import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProteinsDonutChart extends StatefulWidget {
  const ProteinsDonutChart({Key? key}) : super(key: key);

  @override
  _ProteinsDonutChartState createState() => _ProteinsDonutChartState();
}

class _ProteinsDonutChartState extends State<ProteinsDonutChart> {
  @override
  void initState() {
    super.initState();
    // Fetch calorie data from Firestore when the widget is initialized
    _fetchProteinData();
  }

  // FoodLog foodLogInstance = FoodLog();
  late double foodProteins = 0;
  var baseProtein = 125;
  Future<void> _fetchProteinData() async {
    // Assuming you have a collection named 'Nutrition' in Firestore
    // and each document contains a 'Calories' field
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Nutrition')
          // .where('userId',
          //     isEqualTo: 'user?.uid') // Adjust this query accordingly
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Use the first document for simplicity, you may adjust this based on your data model
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          foodProteins = data['Proteins'] ?? 0;
          if (kDebugMode) {
            print(foodProteins);
          } // Default to 0 if 'Calories' is null
        });
      } else {
        // Handle case where no data is found
        if (kDebugMode) {
          print('No data found in Firestore.');
        }
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      if (kDebugMode) {
        print('Error fetching data from Firestore: $error');
      }
    }
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust elevation as needed
      margin: const EdgeInsets.all(16.0), // Adjust margin as needed
      child: SizedBox(
        height: 150, // Adjust height as needed
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                startDegreeOffset: 270,
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                // Adjust radius as needed
                sections: [
                  PieChartSectionData(
                      value: foodProteins,
                      color: Colors.blueAccent,
                      radius: 10,
                      showTitle: false
                      // Adjust radius as needed
                      ),
                  PieChartSectionData(
                    value: (baseProtein.toDouble() - foodProteins),
                    color: Colors.grey,
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
                            "${NumberFormat('#,###').format(baseProtein - foodProteins.toInt())} g",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight
                                    .bold), // Adjust fontSize as needed
                          ),
                        ),
                        Center(
                          child: Text(
                            baseProtein - foodProteins > 0
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
