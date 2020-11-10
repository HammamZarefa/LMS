import 'package:json_annotation/json_annotation.dart';

part 'AddToCartResponse.g.dart';

@JsonSerializable()
class AddToCartResponse {
  String text;
  String cart_url;
  bool redirect;

  AddToCartResponse({this.text, this.cart_url, this.redirect});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => _$AddToCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}

