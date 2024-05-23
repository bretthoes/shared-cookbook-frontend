import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/recipe/recipe_details.dart';
import 'package:boilerplate/presentation/recipe/store/recipe_store.dart';
import 'package:boilerplate/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CookbookDetailsScreen extends StatefulWidget {
  final Cookbook cookbook;
  CookbookDetailsScreen({required this.cookbook});

  @override
  _CookbookDetailsScreenState createState() => _CookbookDetailsScreenState();
}

class _CookbookDetailsScreenState extends State<CookbookDetailsScreen> {
  //stores:---------------------------------------------------------------------
  final PersonStore _personStore = getIt<PersonStore>();
  final RecipeStore _recipeStore = getIt<RecipeStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  TextEditingController _searchController = TextEditingController();
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipes);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    var cookbookId = widget.cookbook.cookbookId ?? 0;
    if (!_recipeStore.loading) {
      if (cookbookId > 0) {
        _recipeStore.getRecipes(cookbookId).then((_) {
          _filterRecipes();
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = _recipeStore.recipeList.recipes.where((recipe) {
        return recipe.title!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(widget.cookbook.title ?? 'No title'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'edit':
                  _editCookbook();
                  break;
                case 'add':
                  _addRecipe();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit cookbook'),
              ),
              const PopupMenuItem<String>(
                value: 'add',
                child: Text('Add recipe'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  void _editCookbook() {
    // Implement the edit functionality
    print('Edit cookbook');
  }

  void _addRecipe() {
    // Implement the delete functionality
    print('Add recipe');
  }

  Widget _buildBody() {
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: _buildColumn(),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16),
        _buildSearchBar(),
        SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.only(left: 16.0), // Add left padding
          child: Text(
            'Recipes',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _buildRecipeList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search recipes, tags...',
        labelStyle:
            TextStyle(color: Colors.grey), // Optional: change label text color
        prefixIcon: Icon(Icons.search,
            color: Colors.grey), // Optional: change icon color
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black), // Optional: border color when not focused
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue), // Optional: border color when focused
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      style: TextStyle(color: Colors.black), // Optional: change text color
    );
  }

  Widget _buildRecipeList() {
    return Observer(
      builder: (_) {
        if (_recipeStore.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _filteredRecipes.length,
          itemBuilder: (context, index) {
            final recipe = _filteredRecipes[index];
            return _buildRecipeItem(recipe, index);
          },
        );
      },
    );
  }

  Widget _buildRecipeItem(Recipe recipe, int index) {
    return ListTile(
      leading: Images.getRecipePreviewImage(recipe.imagePath ?? ''),
      trailing: GestureDetector(
        child: Icon(Icons.favorite_border),
        onTap: () {},
      ),
      title: Text(recipe.title ?? 'No title'),
      subtitle: Row(
        children: [
          Icon(Icons.access_time, size: 16.0),
          SizedBox(width: 4),
          Text(
            _getRecipeText(recipe),
            style: TextStyle(fontSize: 13.0),
          ),
        ],
      ),
      shape: Border(
        top: index > 0 ? BorderSide.none : BorderSide(),
        bottom: BorderSide(),
      ),
      visualDensity: VisualDensity(
        horizontal: -4,
        vertical: 4,
      ),
      contentPadding: EdgeInsets.all(4),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: recipe,
            ),
          ),
        );
      },
    );
  }

  _getRecipeText(Recipe recipe) {
    var totalTime = (recipe.bakingTimeInMinutes ?? 0) +
        (recipe.cookingTimeInMinutes ?? 0) +
        (recipe.preparationTimeInMinutes ?? 0);
    return totalTime > 0 ? '${totalTime} mins' : "Not set";
  }
}
