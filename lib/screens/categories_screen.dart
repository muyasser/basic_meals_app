import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dumy_data.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: DUMMY_CATEGORIES
          .map(
            (catItem) => CategoryItem(
              id: catItem.id,
              title: catItem.title,
              color: catItem.color,
            ),
          )
          .toList(),
    );
  }
}
