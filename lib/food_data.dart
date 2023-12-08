import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module_1/food_data_model.dart';

class FoodProvider {
  Future<List<FoodItem>> fetchData(String query) async {
    const String apiUrl =
        'https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition';
    const String apiKey = '0702284440msh1f07bea7bcdfb1cp1845cdjsn92aa00665f69';

    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'query': query,
    };

    Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        // Parse the JSON list into a list of FoodItem objects
        List<FoodItem> foodItems =
            responseData.map((item) => FoodItem.fromJson(item)).toList();
        return foodItems;
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
