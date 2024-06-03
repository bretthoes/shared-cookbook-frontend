import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';

class RecipeFullScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeFullScreen({required this.recipe});

  @override
  _RecipeFullScreenState createState() => _RecipeFullScreenState();
}

class _RecipeFullScreenState extends State<RecipeFullScreen> {
  bool _isScreenLockEnabled = false;
  bool _isIngredientsExpanded = true;
  bool _isDirectionsExpanded = true;

  // Set to track checked ingredients
  Set<int> _checkedIngredients = Set();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void _toggleScreenLock(bool? value) {
    setState(() {
      _isScreenLockEnabled = value ?? false;
      if (_isScreenLockEnabled) {
        Wakelock.enable();
      } else {
        Wakelock.disable();
      }
    });
  }

  void _toggleIngredients() {
    setState(() {
      _isIngredientsExpanded = !_isIngredientsExpanded;
    });
  }

  void _toggleDirections() {
    setState(() {
      _isDirectionsExpanded = !_isDirectionsExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Steps'),
        actions: [
          Row(
            children: [
              Text('Keep Screen On'),
              Checkbox(
                value: _isScreenLockEnabled,
                onChanged: _toggleScreenLock,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            _buildIngredientsSection(widget.recipe),
            const SizedBox(height: 16),
            _buildDirectionsSection(widget.recipe),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsSection(Recipe recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleIngredients,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                _isIngredientsExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: _buildIngredients(recipe),
          secondChild: Container(),
          crossFadeState: _isIngredientsExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildIngredients(Recipe recipe) {
    var ingredients = recipe.ingredientList!.ingredients;
    ingredients.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return ingredients.isEmpty
        ? Center(child: Text('No ingredients available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < ingredients.length; i++)
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _checkedIngredients.contains(i),
                        onChanged: (bool? value) {
                          setState(() {
                            if (_checkedIngredients.contains(i)) {
                              _checkedIngredients.remove(i);
                            } else {
                              _checkedIngredients.add(i);
                            }
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          '${ingredients[i].ingredientName}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
  }

  Widget _buildDirectionsSection(Recipe recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleDirections,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Directions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                _isDirectionsExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: _buildDirections(recipe),
          secondChild: Container(),
          crossFadeState: _isDirectionsExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Set<int> _struckThroughDirections = Set();

  Widget _buildDirections(Recipe recipe) {
    var directions = recipe.directionList!.directions;
    directions.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return directions.isEmpty
        ? Center(child: Text('No directions available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < directions.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_struckThroughDirections.contains(i)) {
                        _struckThroughDirections.remove(i);
                      } else {
                        _struckThroughDirections.add(i);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _struckThroughDirections.contains(i),
                          onChanged: (bool? value) {
                            setState(() {
                              if (_struckThroughDirections.contains(i)) {
                                _struckThroughDirections.remove(i);
                              } else {
                                _struckThroughDirections.add(i);
                              }
                            });
                          },
                        ),
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Step ${i + 1} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n ${directions[i].directionText}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    decoration:
                                        _struckThroughDirections.contains(i)
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
  }
}
