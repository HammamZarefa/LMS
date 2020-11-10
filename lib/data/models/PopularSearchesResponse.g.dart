// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PopularSearchesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularSearchesResponse _$PopularSearchesResponseFromJson(
    Map<String, dynamic> json) {
  return PopularSearchesResponse(
    searches: (json['searches'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PopularSearchesResponseToJson(
        PopularSearchesResponse instance) =>
    <String, dynamic>{
      'searches': instance.searches,
    };
