import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/ratings/ratings.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/presentation/recipe/recipe_focus.dart';
import 'package:boilerplate/presentation/recipe/store/recipe_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailsScreen({required this.recipe});

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen>
    with SingleTickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  final RecipeStore _recipeStore = getIt<RecipeStore>();

  TextEditingController _searchController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  late TabController _tabController;
  Set<int> _struckThroughDirections = Set();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    var recipeId = widget.recipe.recipeId ?? 0;
    if (!_recipeStore.loading) {
      if (recipeId > 0) {
        _recipeStore.getRecipeDetails(recipeId);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _commentController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit recipe'),
              ),
              const PopupMenuItem<String>(
                value: 'add',
                child: Text('Share recipe'),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Recipe'),
            Tab(text: 'Comments'),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Observer(
      builder: (context) {
        var recipe =
            _recipeStore.recipeList.recipes[_recipeStore.selectedRecipeIndex];
        return _recipeStore.loading
            ? CustomProgressIndicatorWidget()
            : TabBarView(
                controller: _tabController,
                children: [
                  _buildDetailsTab(recipe),
                  _buildCommentsTab(recipe),
                ],
              );
      },
    );
  }

  Widget _buildDetailsTab(Recipe recipe) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.recipe.title ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeFullScreen(
                            recipe: recipe,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.recipe.imagePath ?? '',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildStars(recipe),
            const SizedBox(height: 4.0),
            _buildTimeRow(recipe),
            const SizedBox(height: 12.0),
            _buildIngredients(recipe),
            const SizedBox(height: 12.0),
            _buildDirections(recipe),
            const SizedBox(height: 12.0),
            _buildNutritionInfo(recipe),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsTab(Recipe recipe) {
    var comments = recipe.commentList?.comments ?? [];

    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].commentText ?? ''),
                  subtitle:
                      Text('Anonymous'), // TODO get commenter name with request
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        // TODO post request to add comment, update list
                        // comments.add(Comment(
                        //   commentText: _commentController.text,
                        //   commenterName: 'You',
                        // ));
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(Recipe recipe) {
    var nutrition = recipe.nutrition;

    if (nutrition == null) {
      return Center(child: Text('No nutrition information available.'));
    }

    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            'Nutritional Information',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '(per serving)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Calories: ${nutrition.calories ?? '-'}'),
                Text('Carbs: ${nutrition.carbohydrates ?? '-'}g'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Protein: ${nutrition.protein ?? '-'}g'),
                Text('Fat: ${nutrition.fat ?? '-'}g'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Sugar: ${nutrition.sugar ?? '-'}g'),
          Text('Fiber: ${nutrition.fiber ?? '-'}g'),
          Text('Sodium: ${nutrition.sodium ?? '-'}mg'),
        ],
      ),
    );
  }

  Widget _buildStars(Recipe recipe) {
    var ratings = recipe.ratingList?.ratings;
    double rating = _calculateAverageRating(ratings);
    // Round the rating to the nearest 0.5
    double roundedRating = (rating * 2).round() / 2;

    // Determine the number of filled and half-filled stars
    int fullStars = roundedRating.floor();
    bool hasHalfStar = (roundedRating - fullStars) == 0.5;

    // Create a list of star widgets
    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.amber));
    }

    // Add empty stars to make a total of 5 stars
    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: Colors.amber));
    }
    stars.add(SizedBox(width: 6.0));
    stars.add(Text(rating.toString()));
    stars.add(SizedBox(width: 6.0));
    stars.add(Text(('(' + (ratings?.length.toString() ?? '0') + ')')));

    stars.add(SizedBox(width: 8.0));

    if ((recipe.servings ?? 0) == 0) {
      stars.add(Text('• 1 serving'));
    } else {
      stars.add(Text('• ${recipe.servings} servings'));
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: stars,
    );
  }

  Widget _buildTimeRow(Recipe recipe) {
    var prepTime = recipe.preparationTimeInMinutes ?? 0;
    var cookTime = recipe.cookingTimeInMinutes ?? 0;
    var bakeTime = recipe.bakingTimeInMinutes ?? 0;

    var totalTime = prepTime + cookTime + bakeTime;

    if (totalTime == 0) {
      return SizedBox(height: 0);
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Icon(Icons.timer, color: Colors.grey),
        SizedBox(width: 4),
        Text(
          '${totalTime} min',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        if (prepTime > 0) ...[
          Text(' • Prep: ${prepTime}m'),
        ],
        if (cookTime > 0) ...[
          Text(' • Cooking: ${cookTime}m'),
        ],
        if (bakeTime > 0) ...[
          Text('• Baking: ${bakeTime}m'),
        ],
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
              Text('Ingredients',
                  style: Theme.of(context).textTheme.titleMedium),
              for (var ingredient in ingredients)
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    '• ${ingredient.ingredientName}',
                  ),
                )
            ],
          );
  }

  Widget _buildDirections(Recipe recipe) {
    var directions = recipe.directionList!.directions;

    // Sort directions by the ordinal property
    directions.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return directions.isEmpty
        ? Center(child: Text('No directions available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Directions',
                  style: Theme.of(context).textTheme.titleMedium),
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
                  child: Text(
                    '${i + 1}. ${directions[i].directionText}',
                    style: TextStyle(
                      decoration: _struckThroughDirections.contains(i)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
            ],
          );
  }

  double _calculateAverageRating(List<Rating>? list) {
    if (list == null || list.isEmpty) {
      return 0.0;
    }

    int sum = list.fold(0,
        (previousValue, element) => previousValue + (element.ratingValue ?? 0));

    return sum / list.length;
  }
}
