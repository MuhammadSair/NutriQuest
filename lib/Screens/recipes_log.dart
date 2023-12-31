import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:module_1/Screens/recipe_detail.dart';

class Recipe {
  String id;
  String title;
  String image;
  String readyInMinutes;
  String servings;
  List<String> cuisines;
  List<String> dishTypes;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.cuisines,
    required this.dishTypes,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? '',
      servings: json['servings'] ?? '',
      cuisines: List<String>.from(json['cuisines'] ?? []),
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
    );
  }
}

class RecipeFinder extends StatefulWidget {
  const RecipeFinder({Key? key}) : super(key: key);

  @override
  _RecipeFinderState createState() => _RecipeFinderState();
}

class _RecipeFinderState extends State<RecipeFinder> {
  final TextEditingController queryController = TextEditingController();
  List<Recipe> recipes = [];

  Future<void> fetchRecipes(String query) async {
    final String url = 'https://recipe-by-api-ninjas.p.rapidapi.com/v1/recipe';
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '0702284440msh1f07bea7bcdfb1cp1845cdjsn92aa00665f69',
      'X-RapidAPI-Host': 'recipe-by-api-ninjas.p.rapidapi.com',
    };

    final Uri uri = Uri.parse(url).replace(queryParameters: {'query': query});

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        setState(() {
          recipes = responseData.map((json) => Recipe.fromJson(json)).toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: queryController,
              onSubmitted: (value) {
                final String query = value.trim();
                if (query.isNotEmpty) {
                  fetchRecipes(query);
                }
              },
              decoration: const InputDecoration(
                hintText: 'Enter recipe query',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipes[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      recipe.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(recipe.title),
                  subtitle: Text(
                    'Ready in ${recipe.readyInMinutes} minutes | Servings: ${recipe.servings}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailsScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
