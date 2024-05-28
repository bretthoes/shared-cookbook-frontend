import 'package:boilerplate/domain/entity/Direction/direction_list.dart';
import 'package:boilerplate/domain/entity/comment/comment_list.dart';
import 'package:boilerplate/domain/entity/ingredient/ingredient_list.dart';
import 'package:boilerplate/domain/entity/ingredient_category/ingredient_category_list.dart';
import 'package:boilerplate/domain/entity/nutrition/nutrition.dart';
import 'package:boilerplate/domain/entity/ratings/ratings_list.dart';

class Recipe {
  int? recipeId;
  int? cookbookId;
  String? title;
  int? personId;
  String? summary;
  String? imagePath;
  String? videoPath;
  int? preparationTimeInMinutes;
  int? cookingTimeInMinutes;
  int? bakingTimeInMinutes;
  int? servings;
  Nutrition? nutrition;
  IngredientCategoryList? ingredientCategoryList;
  CommentList? commentList;
  DirectionList? directionList;
  IngredientList? ingredientList;
  RatingList? ratingList;

  Recipe({
    this.recipeId,
    this.cookbookId,
    this.title,
    this.personId,
    this.summary,
    this.imagePath,
    this.videoPath,
    this.preparationTimeInMinutes,
    this.cookingTimeInMinutes,
    this.bakingTimeInMinutes,
    this.servings,
    this.nutrition,
    this.ingredientCategoryList,
    this.commentList,
    this.directionList,
    this.ingredientList,
    this.ratingList,
  });

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
        recipeId: json["recipeId"],
        cookbookId: json["cookbookId"],
        title: json["title"],
        personId: json["personId"],
        summary: json["summary"],
        imagePath: json["imagePath"],
        videoPath: json["videoPath"],
        preparationTimeInMinutes: json["preparationTimeInMinutes"],
        cookingTimeInMinutes: json["cookingTimeInMinutes"],
        bakingTimeInMinutes: json["bakingTimeInMinutes"],
        servings: json["servings"],
        nutrition: Nutrition.fromMap(json["nutrition"]),
        ingredientCategoryList:
            IngredientCategoryList.fromJson(json["ingredientCategories"]),
        commentList: CommentList.fromJson(json["comments"]),
        directionList: DirectionList.fromJson(json["directions"]),
        ingredientList: IngredientList.fromJson(json["ingredients"]),
        ratingList: RatingList.fromJson(json["ratings"]),
      );

  Map<String, dynamic> toMap() => {
        "recipeId": recipeId,
        "cookbookId": cookbookId,
        "title": title,
        "personId": personId,
        "summary": summary,
        "imagePath": imagePath,
        "videoPath": videoPath,
        "preparationTimeInMinutes": preparationTimeInMinutes,
        "cookingTimeInMinutes": cookingTimeInMinutes,
        "bakingTimeInMinutes": bakingTimeInMinutes,
        "servings": servings,
        "nutrition": nutrition?.toMap(),
        "ingredientCategories": ingredientCategoryList?.ingredientCategories
            .map((category) => category.toMap())
            .toList(),
        "comments":
            commentList?.comments.map((comment) => comment.toMap()).toList(),
        "directions": directionList?.directions
            .map((direction) => direction.toMap())
            .toList(),
        "ingredients": ingredientList?.ingredients
            .map((ingredient) => ingredient.toMap())
            .toList(),
        "ratings": ratingList?.ratings.map((rating) => rating.toMap()).toList(),
      };
}
