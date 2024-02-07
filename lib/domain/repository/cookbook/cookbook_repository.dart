import 'dart:async';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';

abstract class CookbookRepository {
  Future<CookbookList> getCookbooks(int personId);

  Future<List<Cookbook>> findCookbookById(int id);

  Future<int> insert(Cookbook cookbook);

  Future<int> update(Cookbook cookbook);

  Future<int> delete(Cookbook cookbook);
}
