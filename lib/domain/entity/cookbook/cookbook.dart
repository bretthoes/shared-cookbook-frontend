class Cookbook {
  int? userId;
  int? id;
  String? title;
  String? body;

  Cookbook({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Cookbook.fromMap(Map<String, dynamic> json) => Cookbook(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
