import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];
  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((element) {
        final filterGluten = settings.isGlutenFree && !element.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !element.isLactoseFree;
        final filterVegan = settings.isVegan && !element.isVegan;
        final filterVegetarian = settings.isVegetarian && !element.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoritesMeals.contains(meal)
          ? _favoritesMeals.remove(meal)
          : _favoritesMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoritesMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        primarySwatch: Colors.pink,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed')),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(_favoritesMeals),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (_) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (_) => SettingsScreen(_filterMeals, settings)
      },
    );
  }
}
