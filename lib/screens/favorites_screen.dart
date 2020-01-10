import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritedMeals;

  FavoritesScreen(this._favoritedMeals);

  Widget build(BuildContext context) {
    return _favoritedMeals.isEmpty
        ? Center(
            child: Text(
              'You have no favorites yet, start adding some!',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: _favoritedMeals.length,
            itemBuilder: (ctx, index) {
              final mealData = _favoritedMeals[index];
              return MealItem(
                id: mealData.id,
                title: mealData.title,
                affordability: mealData.affordability,
                complexity: mealData.complexity,
                duration: mealData.duration,
                imageUrl: mealData.imageUrl,
              );
            },
          );
  }
}
