import 'package:boilerplate/domain/entity/Direction/direction_list.dart';
import 'package:boilerplate/domain/entity/comment/comment_list.dart';
import 'package:boilerplate/domain/entity/ingredient/ingredient_list.dart';
import 'package:boilerplate/domain/entity/ingredient_category/ingredient_category_list.dart';
import 'package:boilerplate/domain/entity/nutrition/nutrition.dart';
import 'package:boilerplate/domain/entity/ratings/ratings_list.dart';

class Recipe {
  int? recipeId;
  int? cookbookId;
  String? authorName;
  String? authorImagePath;
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
    this.authorName,
    this.authorImagePath,
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
        authorName: json["authorName"],
        authorImagePath: json["authorImagePath"],
        title: json["title"],
        personId: json["personId"],
        summary: json["summary"],
        imagePath: json["imagePath"],
        videoPath: json["videoPath"],
        preparationTimeInMinutes: json["preparationTimeInMinutes"],
        cookingTimeInMinutes: json["cookingTimeInMinutes"],
        bakingTimeInMinutes: json["bakingTimeInMinutes"],
        servings: json["servings"],
        nutrition: json["nutrition"] != null
            ? Nutrition.fromMap(json["nutrition"])
            : null,
        ingredientCategoryList: json["ingredientCategories"] != null
            ? IngredientCategoryList.fromJson(json["ingredientCategories"])
            : null,
        commentList: json["recipeComments"] != null
            ? CommentList.fromJson(json["recipeComments"])
            : null,
        directionList: json["recipeDirections"] != null
            ? DirectionList.fromJson(json["recipeDirections"])
            : null,
        ingredientList: json["recipeIngredients"] != null
            ? IngredientList.fromJson(json["recipeIngredients"])
            : null,
        ratingList: json["recipeRatings"] != null
            ? RatingList.fromJson(json["recipeRatings"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "recipeId": recipeId,
        "cookbookId": cookbookId,
        "authorName": authorName,
        "authorImagePath": authorImagePath,
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
