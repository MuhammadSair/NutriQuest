import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'api_service.dart';
import 'modal.dart';

class FitnessDataProcessor {
  final ApiService apiService = ApiService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<void> processAndStoreInFirestore({
    required String? gender,
    required String? activityLevel,
    required int? age,
    required int? weight,
    required int? height,
  }) async {
    FitnessData fit = FitnessData(
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      activityLevel: activityLevel,
    );

    try {
      Map<String, dynamic> responseData = await apiService.getDailyCalorie(fit);

      num bmr = responseData['data']['BMR'];

      Map<String, dynamic> goals = responseData['data']['goals'];

      num maintainWeightCalory = goals['maintain weight'];
      num mildWeightLossCalory = goals['Mild weight loss']['calory'];
      num weightLossCalory = goals['Weight loss']['calory'];
      num extremeWeightLossCalory = goals['Extreme weight loss']['calory'];
      num mildWeightGainCalory = goals['Mild weight gain']['calory'];
      num weightGainCalory = goals['Weight gain']['calory'];
      num extremeWeightGainCalory = goals['Extreme weight gain']['calory'];

      FirebaseFirestore.instance
          .collection('fitnessData')
          .doc(currentUser?.uid)
          .set({
        'BMR': bmr,
        'MaintainWeightCalory': maintainWeightCalory,
        'MildWeightLossCalory': mildWeightLossCalory,
        'WeightLossCalory': weightLossCalory,
        'ExtremeWeightLossCalory': extremeWeightLossCalory,
        'MildWeightGainCalory': mildWeightGainCalory,
        'WeightGainCalory': weightGainCalory,
        'ExtremeWeightGainCalory': extremeWeightGainCalory,
        // Add other fields as needed
      });
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt('BMR', bmr);
      // prefs.setInt('MaintainWeightCalory', maintainWeightCalory);
      // prefs.setInt('MildWeightLossCalory', mildWeightLossCalory);
      // prefs.setInt('WeightLossCalory', weightLossCalory);
      // prefs.setInt('ExtremeWeightLossCalory', extremeWeightLossCalory);
      // prefs.setInt('MildWeightGainCalory', mildWeightGainCalory);
      // prefs.setInt('WeightGainCalory', weightGainCalory);
      // prefs.setInt('ExtremeWeightGainCalory', extremeWeightGainCalory);
      if (kDebugMode) {
        print('Data stored in Firestore successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error processing data and storing in Firestore: $e');
      }
    }
  }

  // Future<Map<String, dynamic>> getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return {
  //     'BMR': prefs.getInt('BMR'),
  //     'MaintainWeightCalory': prefs.getInt('MaintainWeightCalory'),
  //     'MildWeightLossCalory': prefs.getInt('MildWeightLossCalory'),
  //     'WeightLossCalory': prefs.getInt('WeightLossCalory'),
  //     'ExtremeWeightLossCalory': prefs.getInt('ExtremeWeightLossCalory'),
  //     'MildWeightGainCalory': prefs.getInt('MildWeightGainCalory'),
  //     'WeightGainCalory': prefs.getInt('WeightGainCalory'),
  //     'ExtremeWeightGainCalory': prefs.getInt('ExtremeWeightGainCalory'),
  //     'goal': prefs.getString('goal'),
  //   };
  // }
  Future<void> goal(String goal) async {
    FirebaseFirestore.instance.collection('goal').doc(currentUser?.uid).set({
      'goal': goal,
      // Add other fields as needed
    });
  }
}
