import 'package:json_annotation/json_annotation.dart';

part 'PopularSearchesResponse.g.dart';

@JsonSerializable()
class PopularSearchesResponse {
    List<String> searches;

    PopularSearchesResponse({this.searches});

    factory PopularSearchesResponse.fromJson(Map<String, dynamic> json) => _$PopularSearchesResponseFromJson(json);

    Map<String, dynamic> toJson() => _$PopularSearchesResponseToJson(this);
}