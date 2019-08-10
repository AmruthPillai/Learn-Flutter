import 'package:deli_meals_app/data/categories.dart';
import 'package:deli_meals_app/layout/tab_bar_screen.dart';
import 'package:deli_meals_app/models/meal.dart';
import 'package:deli_meals_app/pages/category_meals.dart';
import 'package:deli_meals_app/pages/filters.dart';
import 'package:deli_meals_app/pages/meal_detail.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;
      _meals = DUMMY_MEALS.where((meal) {
        if (_filters['glutenFree'] && !meal.isGlutenFree) return false;
        if (_filters['lactoseFree'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() => _favoriteMeals.removeAt(existingIndex));
    } else {
      setState(() => _favoriteMeals
          .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)));
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        fontFamily: 'Raleway',
      ),
      routes: {
        '/': (ctx) => TabBarScreen(_favoriteMeals),
        CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(_meals),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(_isFavorite, _toggleFavorite),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _setFilters),
      },
    );
  }
}
