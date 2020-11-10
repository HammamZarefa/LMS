// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewAddResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewAddResponse _$ReviewAddResponseFromJson(Map<String, dynamic> json) {
  return ReviewAddResponse(
    error: json['error'] as bool,
    status: json['status'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ReviewAddResponseToJson(ReviewAddResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
    };
