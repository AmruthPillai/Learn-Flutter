import 'package:deli_meals_app/components/category_card.dart';
import 'package:deli_meals_app/data/categories.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3 / 2,
      crossAxisCount: 2,
      children: DUMMY_CATEGORIES
          .map((cat) => CategoryCard(
                id: cat.id,
                title: cat.title,
                color: cat.color,
              ))
          .toList(),
    );
  }
}
