class Cookbook {
  int? cookbookId;
  int? creatorPersonId;
  String? title;
  String? coverPattern;
  String? coverFont;
  String? coverColor;
  String? coverAccentColor;
  String? imagePath;

  Cookbook({
    this.cookbookId,
    this.creatorPersonId,
    this.title,
    this.coverPattern,
    this.coverFont,
    this.coverColor,
    this.coverAccentColor,
    this.imagePath,
  });

  factory Cookbook.fromMap(Map<String, dynamic> json) => Cookbook(
        cookbookId: json["cookbookId"],
        creatorPersonId: json["creatorPersonId"],
        title: json["title"],
        coverPattern: json["coverPattern"],
        coverFont: json["coverFont"],
        coverColor: json["coverColor"],
        coverAccentColor: json["coverAccentColor"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "cookbookId": cookbookId,
        "creatorPersonId": creatorPersonId,
        "title": title,
        "coverPattern": coverPattern,
        "coverFont": coverFont,
        "coverColor": coverColor,
        "coverAccentColor": coverAccentColor,
        "imagePath": imagePath,
      };
}
