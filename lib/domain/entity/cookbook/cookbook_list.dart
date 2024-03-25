import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';

class CookbookList {
  final List<Cookbook> cookbooks;

  CookbookList({
    required this.cookbooks,
  });

  factory CookbookList.fromJson(List<dynamic> json) {
    var cookbooks = json.map((cookbook) => Cookbook.fromMap(cookbook)).toList();
    ;

    return CookbookList(
      cookbooks: cookbooks,
    );
  }
}
