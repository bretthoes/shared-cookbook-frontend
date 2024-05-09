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
      };
}
