class Comment {
  int? recipeCommentId;
  int? recipeId;
  int? personId;
  String? commentText;
  DateTime? created;

  Comment({
    this.recipeCommentId,
    this.recipeId,
    this.personId,
    this.commentText,
    this.created,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        recipeCommentId: json["recipeCommentId"],
        recipeId: json["recipeId"],
        personId: json["personId"],
        commentText: json["commentText"],
        created:
            json["created"] != null ? DateTime.parse(json["created"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "recipeCommentId": recipeCommentId,
        "recipeId": recipeId,
        "personId": personId,
        "commentText": commentText,
        "created": created?.toIso8601String(),
      };
}
