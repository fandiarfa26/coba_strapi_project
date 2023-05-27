// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Failure _$$_FailureFromJson(Map<String, dynamic> json) => _$_Failure(
      status: json['status'] as int?,
      name: json['name'] as String?,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$_FailureToJson(_$_Failure instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'message': instance.message,
    };
