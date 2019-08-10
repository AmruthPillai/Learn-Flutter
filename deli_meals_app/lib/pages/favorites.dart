import 'package:deli_meals_app/components/meal_card.dart';
import 'package:deli_meals_app/models/meal.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesPage(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet, start adding some!'),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) => MealCard(favoriteMeals[index]),
      );
    }
  }
}
