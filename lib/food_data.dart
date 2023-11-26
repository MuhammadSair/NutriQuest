import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodProvider {
  Future fetchData() async {
    const String apiUrl =
        'https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition';
    const String apiKey = '0702284440msh1f07bea7bcdfb1cp1845cdjsn92aa00665f69';

    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'query': '1lb brisket with fries',
    };

    Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
