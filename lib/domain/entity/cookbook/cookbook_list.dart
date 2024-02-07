import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';

class CookbookList {
  final List<Cookbook>? cookbooks;

  CookbookList({
    this.cookbooks,
  });

  factory CookbookList.fromJson(List<dynamic> json) {
    List<Cookbook> cookbooks = <Cookbook>[];
    cookbooks = json.map((cookbook) => Cookbook.fromMap(cookbook)).toList();

    return CookbookList(
      cookbooks: cookbooks,
    );
  }
}
