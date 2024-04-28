// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cookbook_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCookbookParams _$AddCookbookParamsFromJson(Map<String, dynamic> json) =>
    AddCookbookParams(
      creatorPersonId: json['creatorPersonId'] as int,
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$AddCookbookParamsToJson(AddCookbookParams instance) =>
    <String, dynamic>{
      'creatorPersonId': instance.creatorPersonId,
      'title': instance.title,
      'imagePath': instance.imagePath,
    };
