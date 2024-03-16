// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_person_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePersonParams _$UpdatePersonParamsFromJson(Map<String, dynamic> json) =>
    UpdatePersonParams(
      personId: json['personId'] as int,
      displayName: json['displayName'] as String?,
      imagePath: json['imagePath'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdatePersonParamsToJson(UpdatePersonParams instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'displayName': instance.displayName,
      'imagePath': instance.imagePath,
      'password': instance.password,
    };
