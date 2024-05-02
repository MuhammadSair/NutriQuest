import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CalorieDataProvider {
  User? userId = FirebaseAuth.instance.currentUser;
  late String goal;
  late num foodCalorie = 0.0;
  late num base = 0.0;
  num getBaseValue() {
    return base;
  }

  Future<void> fetchData() async {
    await _fetchGoalData();
    // await _fetchCalorieData(userId);
    await _fetchBaseData();
  }

  Future<void> _fetchGoalData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('goal')
          .where('userId', isEqualTo: userId?.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        goal = data['goal'];
        if (kDebugMode) {
          print("Goal value is $goal");
        }
      } else {
        print('No data found in goal Firestore.');
        if (kDebugMode) {
          print("goal userId ${userId?.uid}");
        }
        goal = 'MaintainWeight';
      }
    } catch (error) {
      print('Error fetching goal data from Firestore: $error');
    }
  }

  Future<void> _fetchBaseData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('fitnessData')
          .where('userId', isEqualTo: userId?.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        switch (goal) {
          case 'MaintainWeight':
            base = data['MaintainWeightCalory'];
            break;
          case 'MildWeightLoss':
            base = data['MildWeightLossCalory'];
            break;
          case 'WeightLoss':
            base = data['WeightLossCalory'];
            break;
          case 'ExtremeWeightGain':
            base = data['ExtremeWeightGainCalory'];
            break;
          case 'WeightGain':
            base = data['WeightGainCalory'];
            break;
        }
        if (kDebugMode) {
          print("Base Value is $base");
        }
      } else {
        print('No data found in Base Firestore.');
      }
    } catch (error) {
      print('Error fetching base data from Firestore: $error');
    }
  }
}
