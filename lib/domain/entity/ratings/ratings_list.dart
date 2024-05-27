import 'package:boilerplate/domain/entity/ratings/ratings.dart';

class RatingList {
  final List<Rating> ratings;

  RatingList({
    required this.ratings,
  });

  factory RatingList.fromJson(List<dynamic> json) {
    var recipes = json.map((rating) => Rating.fromMap(rating)).toList();

    return RatingList(
      ratings: recipes,
    );
  }
}
