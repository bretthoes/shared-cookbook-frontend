import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/ratings/ratings.dart';
import 'package:boilerplate/domain/entity/ratings/ratings_list.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/recipe/store/recipe_store.dart';
import 'package:boilerplate/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;
  RecipeDetailsScreen({required this.recipe});

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  //stores:---------------------------------------------------------------------
  final PersonStore _personStore = getIt<PersonStore>();
  final RecipeStore _recipeStore = getIt<RecipeStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  TextEditingController _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    var recipeId = widget.recipe.recipeId ?? 0;
    if (!_recipeStore.loading) {
      if (recipeId > 0) {
        // get ratings
        // get directions
        // get ingredients
        // get nutrition
        // get comments
        _recipeStore.getRecipeDetails(recipeId);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
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
    return Observer(builder: (context) {
      return _recipeStore.loading
        ? CustomProgressIndicatorWidget() 
        : Material(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildColumn(),
          ),
        );
      },
    );
  }

  Widget _buildColumn() {
    return Observer(
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              widget.recipe.title ?? '',
              style: Theme.of(context).textTheme.labelLarge,
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
            _buildStars(),
            _buildTimeRow()
          ],
        );
      },
    );
  }
  
  Widget _buildStars() {
    var recipe = _recipeStore.recipeList.recipes[_recipeStore.selectedRecipeIndex];
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
    stars.add(SizedBox(width: 6.0,));
    stars.add(Text(rating.toString()));
    stars.add(SizedBox(width: 6.0,));
    stars.add(Text(('(' + (ratings?.length.toString() ?? '0') + ')')));

    stars.add(SizedBox(width: 8.0,));

    stars.add(Text('• ${recipe.commentList?.comments.length ?? 0} comments'));

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: stars,
    );
  }

  Widget _buildTimeRow() {
  var recipe = _recipeStore.recipeList.recipes[_recipeStore.selectedRecipeIndex];
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
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
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

  double _calculateAverageRating(List<Rating>? list) {
    if (list == null || list.isEmpty) {
      return 0.0;
    }

    int sum = list.fold(0,
        (previousValue, element) => previousValue + (element.ratingValue ?? 0));

    return sum / list.length;
  }
}
