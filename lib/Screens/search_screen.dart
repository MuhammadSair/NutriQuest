import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:module_1/provider/food_data_provider.dart';
import 'package:module_1/Models/food_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _mounted = true;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  List<String> suggestions = [];

  final FoodProvider foodProvider = FoodProvider();
  final TextEditingController _foodQueryController = TextEditingController();
  // Getter for foodCalorie
  User? currentUser = FirebaseAuth.instance.currentUser;

  String query = "";
  dynamic foodCalorie;
  dynamic protein;
  dynamic fats;
  dynamic carbohydrates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrional fact'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: "'e.g., 1lb brisket with fries'",
              controller: _foodQueryController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
                // _fetchSuggestions();
              },
              onSubmitted: (value) {
                setState(() {
                  query = _foodQueryController.text;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: foodProvider.fetchData(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Add to Your Stomach :)'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FoodItem foodItem = snapshot.data![index];
                      foodCalorie = foodItem.calories;
                      protein = foodItem.proteinG;
                      carbohydrates = foodItem.carbohydratesTotalG;
                      fats = foodItem.fatTotalG;

                      return ListTile(
                          title: Text(foodItem.name),
                          subtitle: Text(
                              'Calories: ${foodItem.calories} kcal ServingSize: ${foodItem.servingSizeG} g  '),
                          trailing: InkWell(
                            onTap: () {
                              _updateFirestore();
                            },
                            child: Icon(Icons.add),
                          )

                          // Add more details as needed
                          );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateSharedPreferences(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Calories', data['Calories'] ?? 0);
    prefs.setInt('Proteins', data['Proteins'] ?? 0);
    prefs.setInt('Fats', data['Fats'] ?? 0);
    prefs.setInt('Carbs', data['Carbs'] ?? 0);
  }

  static Future<Map<String, dynamic>> _getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'Calories': prefs.getInt('Calories') ?? 0,
      'Proteins': prefs.getInt('Proteins') ?? 0,
      'Fats': prefs.getInt('Fats') ?? 0,
      'Carbs': prefs.getInt('Carbs') ?? 0,
    };
  }

  Future<void> _updateFirestore() async {
    // Get the reference to the document
    DocumentReference nutritionDocRef = FirebaseFirestore.instance
        .collection('Nutrition')
        .doc(currentUser!.uid);

    // Fetch the existing data
    DocumentSnapshot docSnapshot = await nutritionDocRef.get();

    // Check if the document exists
    Map<String, dynamic> existingData;
    if (docSnapshot.exists) {
      // If the document exists, use its data
      existingData = docSnapshot.data() as Map<String, dynamic>;
    } else {
      // If the document doesn't exist, initialize with default values
      existingData = {
        'Calories': 0,
        'Proteins': 0,
        'Fats': 0,
        'Carbs': 0,
        'userId': currentUser!.uid,
      };
    }

    // Update the values
    existingData['Calories'] =
        (existingData['Calories'] ?? 0) + (foodCalorie ?? 0);
    existingData['Proteins'] = (existingData['Proteins'] ?? 0) + (protein ?? 0);
    existingData['Fats'] = (existingData['Fats'] ?? 0) + (fats ?? 0);
    existingData['Carbs'] = (existingData['Carbs'] ?? 0) + (carbohydrates ?? 0);

    // Set the updated data back to Firestore
    await nutritionDocRef.set(existingData);
    // await _updateSharedPreferences(existingData);
    if (_mounted) {
      setState(() {
        foodCalorie = existingData['Calories'];
        protein = existingData['Proteins'];
        fats = existingData['Fats'];
        carbohydrates = existingData['Carbs'];
      });
    } else
      (error) {
        // Handle errors
        print('Error updating Firestore: $error');
      };
  }
}
