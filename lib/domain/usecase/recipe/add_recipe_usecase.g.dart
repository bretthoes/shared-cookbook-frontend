// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_recipe_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRecipeParams _$AddRecipeParamsFromJson(Map<String, dynamic> json) =>
    AddRecipeParams(
      creatorPersonId: json['creatorPersonId'] as int,
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$AddRecipeParamsToJson(AddRecipeParams instance) =>
    <String, dynamic>{
      'creatorPersonId': instance.creatorPersonId,
      'title': instance.title,
      'imagePath': instance.imagePath,
    };
