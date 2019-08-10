import 'package:deli_meals_app/pages/category_meals.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryCard({Key key, this.id, this.title, this.color})
      : super(key: key);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsPage.routeName,
      arguments: {
        'id': id,
        'title': title,
        'color': color,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            selectCategory(context);
          },
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
