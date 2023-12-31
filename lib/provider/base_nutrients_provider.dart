import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module_1/Models/base_nutrients_model.dart';

class BaseProvider {
  Future<List<FitnessCalculatorResponse>> fetchData(
    String age,
    String gender,
    String height,
    String weight,
    String activityLevel,
  ) async {
    const String url = 'https://fitness-calculator.p.rapidapi.com/dailycalorie';
    // https://fitness-calculator.p.rapidapi.com/dailycalorie?age=25&gender=male&height=180&weight=70&activitylevel=level_1

    Map<String, String> queryParams = {
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'activitylevel': activityLevel,
    };

    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    Map<String, String> headers = {
      'X-RapidAPI-Key': '0702284440msh1f07bea7bcdfb1cp1845cdjsn92aa00665f69',
      'X-RapidAPI-Host': 'fitness-calculator.p.rapidapi.com',
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Parse JSON response using model classes
        FitnessCalculatorResponse calculatorResponse =
            FitnessCalculatorResponse.fromJson(json.decode(response.body));

        // Return the parsed data directly
        return [calculatorResponse];
      } else {
        // Throw an exception in case of an error
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Throw an exception in case of an error
      throw Exception('Error: $error');
    }
  }
}
