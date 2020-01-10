import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> _filters;
  final Function _saveFilters;

  FiltersScreen(this._filters, this._saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  @override
  void initState() {
    _glutenFree = widget._filters['gluten'];
    _vegetarian = widget._filters['vegan'];
    _vegan = widget._filters['vegan'];
    _lactoseFree = widget._filters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> _selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };

              widget._saveFilters(_selectedFilters);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include Gluten-free meals.',
                  _glutenFree,
                  (bool newValue) {
                    if (_glutenFree != newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (bool newValue) {
                    if (_vegetarian != newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (bool newValue) {
                    if (_vegan != newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include Lactose-free meals.',
                  _lactoseFree,
                  (bool newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
