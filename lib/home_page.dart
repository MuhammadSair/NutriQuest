import 'package:flutter/material.dart';
import 'package:module_1/food_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodProvider foodProvider = FoodProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: foodProvider.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return ListView(
            children: [
              ListTile(
                title: Text(snapshot.data.toString()),
              ),
            ],
          );
        }
      },
    );
  }
}
