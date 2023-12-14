import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatefulWidget {
  const DonutChart({Key? key}) : super(key: key);

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
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
                startDegreeOffset: 250,
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                // Adjust radius as needed
                sections: [
                  PieChartSectionData(
                      value: 10,
                      color: Colors.blueAccent,
                      radius: 10,
                      showTitle: false
                      // Adjust radius as needed
                      ),
                  PieChartSectionData(
                    value: 35,
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
                    child: const Center(
                      child: Text(
                        "Remaining Calories",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12), // Adjust fontSize as needed
                      ),
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
