import 'package:flutter/material.dart';
import 'package:meals_app/dumy_data.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meal.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      // _availableMeals = DUMMY_MEALS.where((meal) {
      //   if (meal.isGlutenFree == _filters['gluten'] &&
      //       meal.isVegetarian == _filters['vegetarian'] &&
      //       meal.isVegan == _filters['vegan'] &&
      //       meal.isLactoseFree == _filters['lactose']) {
      //     return true;
      //   } else {
      //     return false;
      //   }
      // }).toList();

      _availableMeals = DUMMY_MEALS.where((meal) {
        // عاوزه يرجع ال meal اللي ليها الخصائص بتاعت ال filters كلها
        // إذا في حتى شرط واح متحققش مع ال meal مش هرجعها
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => TabsScreen(_favoriteMeals),
        CategoriesScreen.routeName: (BuildContext context) =>
            CategoriesScreen(),
        CategoryMealsScreen.routeName: (BuildContext context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (BuildContext context) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (BuildContext context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
