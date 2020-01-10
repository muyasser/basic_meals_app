import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  bool loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      super.didChangeDependencies();

      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];

      displayedMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      loadedInitData = true;
    }
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (ctx, index) {
          final mealData = displayedMeals[index];
          return MealItem(
            id: mealData.id,
            title: mealData.title,
            affordability: mealData.affordability,
            complexity: mealData.complexity,
            duration: mealData.duration,
            imageUrl: mealData.imageUrl,
          );
        },
      ),
    );
  }
}
