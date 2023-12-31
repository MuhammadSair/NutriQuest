import 'package:http/http.dart' as http;

void fetchData() async {
  final String url = 'https://food-recipes-with-images.p.rapidapi.com/';
  final Map<String, String> queryParams = {'q': 'chicken soup'};
  final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

  final Map<String, String> headers = {
    'X-RapidAPI-Key': '0702284440msh1f07bea7bcdfb1cp1845cdjsn92aa00665f69',
    'X-RapidAPI-Host': 'food-recipes-with-images.p.rapidapi.com',
  };

  try {
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
