import 'dart:async';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';

abstract class CookbookRepository {
  Future<CookbookList> getCookbooks(int personId);

  Future<List<Cookbook>> findCookbookById(int id);

  Future<Cookbook?> add(AddCookbookParams cookbook);

  Future<int> update(Cookbook cookbook);

  Future<int> delete(Cookbook cookbook);
}
