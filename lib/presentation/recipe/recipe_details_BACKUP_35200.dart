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
  final RecipeStore _recipeStore = getIt<RecipeStore>();

  var _searchController = TextEditingController();
  var _commentController = TextEditingController();
  late TabController _tabController;

  var _isIngredientsExpanded = false;
  var _isDirectionsExpanded = false;
  var _isNutritionExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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
            : _buildDetailsColumn(recipe);
      },
    );
  }

  Widget _buildDetailsColumn(Recipe recipe) {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              aspectRatio: 1,
              child: ClipRRect(
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
<<<<<<< HEAD
            _buildIngredientsSection(recipe),
            const SizedBox(height: 12.0),
            _buildDirectionsSection(recipe),
            const SizedBox(height: 12.0),
            _buildNutritionInfoSection(recipe),
            const SizedBox(height: 12.0),
            _buildReviewSection(recipe),
||||||| merged common ancestors
            _buildIngredientsSection(recipe),
            const SizedBox(height: 12.0),
            _buildDirectionsSection(recipe),
            const SizedBox(height: 12.0),
            _buildNutritionInfoSection(recipe),
=======
            _buildExpandableSection(
              title: 'Ingredients',
              icon: Icons.kitchen_outlined,
              isExpanded: _isIngredientsExpanded,
              onTap: _toggleIngredients,
              child: _buildIngredients(recipe),
            ),
            _buildExpandableSection(
              title: 'Directions',
              icon: Icons.map_outlined,
              isExpanded: _isDirectionsExpanded,
              onTap: _toggleDirections,
              child: _buildDirections(recipe),
            ),
            _buildExpandableSection(
              title: 'Nutrition Info',
              icon: Icons.fastfood_outlined,
              isExpanded: _isNutritionExpanded,
              onTap: _toggleNutrition,
              child: _buildNutritionInfo(recipe),
            ),
>>>>>>> 12c7032f8b0247fbf217fbbbb53ab059f7265aac
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection(Recipe recipe) {
    var comments = recipe.commentList?.comments ?? [];

<<<<<<< HEAD
    return Column(
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
||||||| merged common ancestors
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
=======
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].commentText ?? ''),
                  subtitle: Text('Anonymous'),
                );
              },
            ),
>>>>>>> 12c7032f8b0247fbf217fbbbb53ab059f7265aac
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
<<<<<<< HEAD
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
||||||| merged common ancestors
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
=======
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
>>>>>>> 12c7032f8b0247fbf217fbbbb53ab059f7265aac
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection({
  required String title,
  required IconData icon,
  required bool isExpanded,
  required VoidCallback onTap,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.symmetric(vertical: 4.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    SizedBox(width: 8.0),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
          secondChild: Container(),
          crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 300),
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

  Widget _buildIngredients(Recipe recipe) {
    var ingredients = recipe.ingredientList!.ingredients;

    ingredients.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return ingredients.isEmpty
        ? Center(child: Text('No ingredients available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var ingredient in ingredients)
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('• ${ingredient.ingredientName}'),
                )
            ],
          );
  }

  Widget _buildDirections(Recipe recipe) {
    var directions = recipe.directionList!.directions;

    directions.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return directions.isEmpty
        ? Center(child: Text('No directions available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < directions.length; i++)
                Text(
                  '${i + 1}. ${directions[i].directionText}',
                  style: TextStyle(),
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
          Text(' • Baking: ${bakeTime}m'),
        ],
      ],
    );
  }

<<<<<<< HEAD
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

  Widget _buildIngredients(Recipe recipe) {
    var ingredients = recipe.ingredientList!.ingredients;

    ingredients.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return ingredients.isEmpty
        ? Center(child: Text('No ingredients available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

    directions.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return directions.isEmpty
        ? Center(child: Text('No directions available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < directions.length; i++)
                Text(
                  '${i + 1}. ${directions[i].directionText}',
                  style: TextStyle(),
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

||||||| merged common ancestors
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

  Widget _buildIngredients(Recipe recipe) {
    var ingredients = recipe.ingredientList!.ingredients;

    ingredients.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return ingredients.isEmpty
        ? Center(child: Text('No ingredients available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

    directions.sort((a, b) => a.ordinal!.compareTo(b.ordinal!));

    return directions.isEmpty
        ? Center(child: Text('No directions available.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < directions.length; i++)
                Text(
                  '${i + 1}. ${directions[i].directionText}',
                  style: TextStyle(),
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

  
=======
>>>>>>> 12c7032f8b0247fbf217fbbbb53ab059f7265aac
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

  void _toggleNutrition() {
    setState(() {
      _isNutritionExpanded = !_isNutritionExpanded;
    });
  }
}
