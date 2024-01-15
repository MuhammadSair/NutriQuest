import 'dart:convert';
import 'package:http/http.dart' as http;
import 'modal.dart';

class ApiService {
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com';
  final String apiKey = 'e871c20e3dmshc3d86d0a8b99ac7p1d9eb4jsn4a9a131b30e9';

  Future<Map<String, dynamic>> getDailyCalorie(FitnessData data) async {
    print(data.age);
    print(data.height);
    print(data.weight);
    print(data.activityLevel);
    final Uri uri = Uri.parse(
        '$baseUrl/dailycalorie?age=${data.age}&gender=${data.gender}&height=${data.height}&weight=${data.weight}&activitylevel=${data.activityLevel}');

    final Uri uri1 = Uri.parse(
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
        // Parse and return the result
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
