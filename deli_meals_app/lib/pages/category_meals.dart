import 'package:deli_meals_app/components/meal_card.dart';
import 'package:deli_meals_app/models/meal.dart';
import 'package:flutter/material.dart';

class CategoryMealsPage extends StatefulWidget {
  static const String routeName = '/meals';
  final List<Meal> _meals;

  const CategoryMealsPage(this._meals);

  @override
  _CategoryMealsPageState createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  String id;
  String title;
  Color color;
  List<Meal> meals;
  bool _loadedData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      id = routeArgs['id'];
      title = routeArgs['title'];
      color = routeArgs['color'] as Color;

      meals =
          widget._meals.where((meal) => meal.categories.contains(id)).toList();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealCard(meals[index]),
      ),
    );
  }
}
