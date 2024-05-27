class Rating {
  int? recipeRatingId;
  int? recipeId;
  int? personId;
  int? ratingValue;
  DateTime? created;

  Rating({
    this.recipeRatingId,
    this.recipeId,
    this.personId,
    this.ratingValue,
    this.created,
  });

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        recipeRatingId: json["recipeRatingId"],
        recipeId: json["recipeId"],
        personId: json["personId"],
        ratingValue: json["ratingValue"],
        created:
            json["created"] != null ? DateTime.parse(json["created"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "recipeRatingId": recipeRatingId,
        "recipeId": recipeId,
        "personId": personId,
        "ratingValue": ratingValue,
        "created": created?.toIso8601String(),
      };
}
