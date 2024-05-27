import 'package:boilerplate/domain/entity/comment/comment.dart';

class CommentList {
  final List<Comment> comments;

  CommentList({
    required this.comments,
  });

  factory CommentList.fromJson(List<dynamic> json) {
    var comments = json.map((comment) => Comment.fromMap(comment)).toList();

    return CommentList(
      comments: comments,
    );
  }
}
