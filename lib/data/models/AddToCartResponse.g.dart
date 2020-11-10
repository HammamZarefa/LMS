// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddToCartResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) {
  return AddToCartResponse(
    text: json['text'] as String,
    cart_url: json['cart_url'] as String,
    redirect: json['redirect'] as bool,
  );
}

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'cart_url': instance.cart_url,
      'redirect': instance.redirect,
    };
