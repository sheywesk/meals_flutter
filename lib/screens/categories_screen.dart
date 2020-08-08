import 'package:flutter/material.dart';
import 'package:meals/components/category_item.dart';
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
        maxCrossAxisExtent: 200,
      ),
      children: <Widget>[...DUMMY_CATEGORIES.map((e) => CategoryItem(e))],
    );
  }
}
