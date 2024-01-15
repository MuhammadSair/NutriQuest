import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modal.dart';

class ApiService {
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com';
  final String apiKey = 'e871c20e3dmshc3d86d0a8b99ac7p1d9eb4jsn4a9a131b30e9';

  Future<DailyCalorieData> getDailyCalorie(FitnessData data) async {
    print(data.age);
    print(data.height);
    print(data.weight);
    print(data.activityLevel);
    final Uri uri = Uri.parse(
        '$baseUrl/dailycalorie?age=${data.age}&gender=${data.gender}&height=${data.height}&weight=${data.weight}&activitylevel=${data.activityLevel}');

    try {
      final response = await http.get(
        uri,
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'fitness-calculator.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        // Parse and return an instance of DailyCalorieData
        return DailyCalorieData.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// Define a Dart class to represent the structure of the API response
class DailyCalorieData {
  final double bmr;
  final Map<String, dynamic> goals;

  DailyCalorieData({
    required this.bmr,
    required this.goals,
  });

  // Factory method to create an instance of DailyCalorieData from a JSON map
  factory DailyCalorieData.fromJson(Map<String, dynamic> json) {
    return DailyCalorieData(
      bmr: json['data']['BMR'].toDouble(),
      goals: json['data']['goals'],
    );
  }
}
