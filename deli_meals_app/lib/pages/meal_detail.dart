import 'package:deli_meals_app/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  static const String routeName = '/meal-detail';
  final Function isFavorite;
  final Function toggleFavorite;

  MealDetailPage(this.isFavorite, this.toggleFavorite);

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;

    Text _buildTitle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget _buildIngredientsSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle('Ingredients'),
          SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: meal.ingredients.map((ing) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(ing),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      );
    }

    Widget _buildStepsSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle('Steps'),
          SizedBox(height: 5),
          Column(
            children: meal.steps.map((step) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.restaurant_menu,
                          size: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(step),
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildIngredientsSection(),
                  Divider(
                    color: Colors.black54,
                    height: 30,
                  ),
                  _buildStepsSection(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(meal.id) ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () {
          toggleFavorite(meal.id);
        },
      ),
    );
  }
}
