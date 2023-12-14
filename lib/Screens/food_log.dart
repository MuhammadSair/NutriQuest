import 'package:flutter/material.dart';
import 'package:module_1/provider/food_data_provider.dart';
import 'package:module_1/Models/food_data_model.dart';

class FoodLog extends StatefulWidget {
  const FoodLog({super.key});

  @override
  State<FoodLog> createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  final FoodProvider foodProvider = FoodProvider();
  final TextEditingController _foodQueryController = TextEditingController();
  String query = "";

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
            child: TextField(
              controller: _foodQueryController,
              onSubmitted: (value) {
                setState(() {
                  query = _foodQueryController.text;
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Enter Query',
                hintText: 'e.g., 1lb brisket with fries',
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     setState(() {
          //       query = _foodQueryController.text;
          //     });
          //   },
          //   child: const Text("Get the facts"),
          // ),
          Expanded(
            child: FutureBuilder(
              future: foodProvider.fetchData(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FoodItem foodItem = snapshot.data![index];
                      return ListTile(
                        title: Text(foodItem.name),
                        subtitle: Text(
                            'Calories: ${foodItem.calories} kcal \nServingSize: ${foodItem.servingSizeG} g \nCarbohydrates: ${foodItem.carbohydratesTotalG}gram \nProteins: ${foodItem.proteinG}gram \nTotalFat: ${foodItem.fatTotalG}gram \nSaturatedFat: ${foodItem.fatSaturatedG}gram \nCholestrol: ${foodItem.cholesterolMg}mg \nFiber: ${foodItem.fiberG}g \nSugar: ${foodItem.sugarG}g  '),

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
}
