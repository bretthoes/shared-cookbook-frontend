import 'package:boilerplate/core/widgets/back_button_app_bar_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
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
      appBar: BackButtonAppBar(
        title: widget.cookbook.title ?? 'No title', // TODO localize
      ),
      body: _buildBody(),
    );
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
      children: <Widget>[
        _buildSearchBar(),
        SizedBox(height: 64),
        Text('Recipes'),
        _buildRecipeList(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search Recipes',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
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
            return _buildRecipeItem(recipe);
          },
        );
      },
    );
  }

  Widget _buildRecipeItem(Recipe recipe) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0), // Optional: adds some space around the container
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Color of the border
          width: 1.0, // Width of the border
        ),
        borderRadius:
            BorderRadius.circular(8.0), // Optional: makes the corners rounded
      ),
      child: SizedBox(
        height: 100.0, // Set the desired height here
        child: ListTile(
          leading: Images.getCoverImage(recipe.imagePath ?? ''),
          title: Text(recipe.title ?? 'No title'),
          subtitle:
              Text('Prep time: ${recipe.preparationTimeInMinutes} minutes'),
          onTap: () {
            // Handle recipe tap
          },
        ),
      ),
    );
  }
}
