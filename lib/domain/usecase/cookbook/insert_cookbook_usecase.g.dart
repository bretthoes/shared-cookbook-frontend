// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_cookbook_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertCookbookParams _$InsertCookbookParamsFromJson(
        Map<String, dynamic> json) =>
    InsertCookbookParams(
      creatorPersonId: json['creatorPersonId'] as int,
      title: json['title'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$InsertCookbookParamsToJson(
        InsertCookbookParams instance) =>
    <String, dynamic>{
      'creatorPersonId': instance.creatorPersonId,
      'title': instance.title,
      'imagePath': instance.imagePath,
    };
