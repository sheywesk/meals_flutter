import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChanged;
  final Settings settings;
  const SettingsScreen(this.onSettingsChanged, this.settings);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings setting;
  @override
  void initState() {
    super.initState();
    setting = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(setting);
      },
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Configurações',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _createSwitch(
                    'Sem glutén',
                    'Só exibe refeições sem glutén',
                    setting.isGlutenFree,
                    (value) => setState(() => setting.isGlutenFree = value),
                  ),
                  _createSwitch(
                    'Sem Lactose',
                    'Só exibe refeições sem lactose',
                    setting.isLactoseFree,
                    (value) => setState(() => setting.isLactoseFree = value),
                  ),
                  _createSwitch(
                    'Vegana',
                    'Só exibe refeições veganas',
                    setting.isVegan,
                    (value) => setState(() => setting.isVegan = value),
                  ),
                  _createSwitch(
                    'Vegetariana',
                    'Só exibe refeições vegetarianas',
                    setting.isVegetarian,
                    (value) => setState(() => setting.isVegetarian = value),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
