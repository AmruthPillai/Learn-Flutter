import 'package:deli_meals_app/layout/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget {
  static const String routeName = '/filters';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  const FiltersPage(this.currentFilters, this.saveFilters);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['glutenFree'];
    _lactoseFree = widget.currentFilters['lactoseFree'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, bool> selectedFilters = {
            'glutenFree': _glutenFree,
            'lactoseFree': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian,
          };
          widget.saveFilters(selectedFilters);
        },
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection here',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten Free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(() => _glutenFree = newValue);
                  },
                ),
                _buildSwitchListTile(
                  'Lactose Free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(() => _lactoseFree = newValue);
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() => _vegan = newValue);
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(() => _vegetarian = newValue);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
