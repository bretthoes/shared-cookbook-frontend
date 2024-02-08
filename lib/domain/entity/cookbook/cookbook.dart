class Cookbook {
  int? personId;
  int? id;
  String? title;
  String? body;

  Cookbook({
    this.personId,
    this.id,
    this.title,
    this.body,
  });

  factory Cookbook.fromMap(Map<String, dynamic> json) => Cookbook(
        personId: json["personId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "personId": personId,
        "id": id,
        "title": title,
        "body": body,
      };
}
