import 'package:flutter/material.dart';
import 'api_service.dart';
import 'modal.dart';

class MyWidget extends StatelessWidget {
  String? gender;

  String? activityLevel;

  int? age;

  int? weight;

  int? height;
  MyWidget(
      {required this.gender,
      required this.activityLevel,
      required this.age,
      required this.weight,
      required this.height});
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    FitnessData fit = FitnessData(
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      activityLevel: activityLevel,
    );

    return FutureBuilder<Map<String, dynamic>>(
      future: apiService.getDailyCalorie(fit),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Access the data using snapshot.data
          Map<String, dynamic> responseData = snapshot.data!;

          // Access the BMR value
          int bmr = responseData['data']['BMR'];

          // Access the 'goals' field
          Map<String, dynamic> goals = responseData['data']['goals'];

          // Access specific sub-fields
          // Access specific sub-fields
          int maintainWeightCalory = goals['maintain weight'];
          int mildWeightLossCalory = goals['Mild weight loss']['calory'];
          int weightLossCalory = goals['Weight loss']['calory'];
          int extremeWeightLossCalory = goals['Extreme weight loss']['calory'];
          int mildWeightGainCalory = goals['Mild weight gain']['calory'];
          int weightGainCalory = goals['Weight gain']['calory'];
          int extremeWeightGainCalory = goals['Extreme weight gain']['calory'];
          // Access other sub-fields as needed

          // Print or use the data as needed
          // print('BMR: $bmr');
          // print('Maintain Weight Calory: $maintainWeightCalory');
          // print('Mild Weight Loss Calory: $mildWeightLossCalory');

          return Container(
            // Your UI components here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BMR: $bmr'),
                Text('Maintain Weight Calory: $maintainWeightCalory'),
                Text('Mild Weight Loss Calory: $mildWeightLossCalory'),
                Text('Weight Loss Calory: $weightLossCalory'),
                Text('Extreme Weight Loss Calory: $extremeWeightLossCalory'),
                Text('Mild Weight Gain Calory: $mildWeightGainCalory'),
                Text('Weight Gain Calory: $weightGainCalory'),
                Text('Extreme Weight Gain Calory: $extremeWeightGainCalory'),
                // Add other UI components for other fields
              ],
            ),
          );
        }
      },
    );
  }
}
