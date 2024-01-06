import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChartsData {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future fetchCalorieData() async {
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

        var foodCalorie = data['Calories'] ?? 0;
        return foodCalorie;
        // if (kDebugMode) {
        //   print(foodCalorie);
        // } // Default to 0 if 'Calories' is null
      } else {
        // Handle case where no data is found
        print('No data found in Firestore.');
      }
    } catch (error) {
      // Handle any errors that occur during the fetch operation
      print('Error fetching data from Firestore: $error');
    }
  }
}
