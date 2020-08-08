import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;
  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _screens = [
      {
        'title': 'Lista de categorias',
        'screen': CategoriesScreen(),
      },
      {
        'title': 'Meus Favoritos',
        'screen': FavoriteScreen(widget.favoriteMeals),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_screens[_selectedScreenIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _screens[_selectedScreenIndex]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amberAccent,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('Categorias'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}
