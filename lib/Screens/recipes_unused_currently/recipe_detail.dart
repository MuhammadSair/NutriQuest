import 'package:flutter/material.dart';

import 'package:module_1/Screens/recipes_unused_currently/recipes_log.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(recipe.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Ready in ${recipe.readyInMinutes} minutes | Servings: ${recipe.servings}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Cuisines: ${recipe.cuisines.join(', ')}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Dish Types: ${recipe.dishTypes.join(', ')}'),
          ),
          // Add more details as needed
        ],
      ),
    );
  }
}
