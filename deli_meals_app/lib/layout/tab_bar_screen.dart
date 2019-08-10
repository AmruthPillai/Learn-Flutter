import 'package:deli_meals_app/layout/main_drawer.dart';
import 'package:deli_meals_app/models/meal.dart';
import 'package:deli_meals_app/pages/categories.dart';
import 'package:deli_meals_app/pages/favorites.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabBarScreen(this.favoriteMeals);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('DeliMeals'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesPage(),
            FavoritesPage(widget.favoriteMeals),
          ],
        ),
      ),
    );
  }
}
