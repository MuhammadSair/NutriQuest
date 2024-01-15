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
  // SharedPreferences uidpref=await SharedPreferences.getInstance();
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
      // prefs.setDouble('BMR', bmr as double);
      // prefs.setDouble('MaintainWeightCalory', maintainWeightCalory as double);
      // prefs.setDouble('MildWeightLossCalory', mildWeightLossCalory as double);
      // prefs.setDouble('WeightLossCalory', weightLossCalory as double);
      // prefs.setDouble(
      //     'ExtremeWeightLossCalory', extremeWeightLossCalory as double);
      // prefs.setDouble('MildWeightGainCalory', mildWeightGainCalory as double);
      // prefs.setDouble('WeightGainCalory', weightGainCalory as double);
      // prefs.setDouble(
      //     'ExtremeWeightGainCalory', extremeWeightGainCalory as double);
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
  //     'BMR': prefs.getDouble('BMR'),
  //     'MaintainWeightCalory': prefs.getDouble('MaintainWeightCalory'),
  //     'MildWeightLossCalory': prefs.getDouble('MildWeightLossCalory'),
  //     'WeightLossCalory': prefs.getDouble('WeightLossCalory'),
  //     'ExtremeWeightLossCalory': prefs.getDouble('ExtremeWeightLossCalory'),
  //     'MildWeightGainCalory': prefs.getDouble('MildWeightGainCalory'),
  //     'WeightGainCalory': prefs.getDouble('WeightGainCalory'),
  //     'ExtremeWeightGainCalory': prefs.getDouble('ExtremeWeightGainCalory'),
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
