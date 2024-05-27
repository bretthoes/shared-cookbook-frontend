class Direction {
  int? recipeDirectionId;
  int? recipeId;
  String? directionText;
  int? ordinal;
  String? imagePath;

  Direction({
    this.recipeDirectionId,
    this.recipeId,
    this.directionText,
    this.ordinal,
    this.imagePath,
  });

  factory Direction.fromMap(Map<String, dynamic> json) => Direction(
        recipeDirectionId: json["recipeDirectionId"],
        recipeId: json["recipeId"],
        directionText: json["directionText"],
        ordinal: json["ordinal"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "recipeDirectionId": recipeDirectionId,
        "recipeId": recipeId,
        "directionText": directionText,
        "ordinal": ordinal,
        "imagePath": imagePath,
      };
}
