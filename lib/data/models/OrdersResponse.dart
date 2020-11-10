import 'package:json_annotation/json_annotation.dart';

part 'OrdersResponse.g.dart';

class OrdersResponse {
  final List<OrderBean> orders;

  OrdersResponse(
    this.orders,
  );

  OrdersResponse.fromJsonArray(List json)
      : orders = json.map((i) => new OrderBean.fromJson(i)).toList();
}

@JsonSerializable()
class OrderBean {
  String user_id;
  List<ItemsBean> items;
  String date;
  String status;
  String payment_code;
  String order_key;
  @JsonKey(name: "_order_total")
  String order_total;
  @JsonKey(name: "_order_currency")
  String order_currency;
  I18nBean i18n;
  num id;
  String date_formatted;
  List<Cart_itemsBean> cart_items;
  String total;
  UserBean user;

  OrderBean(
      {this.user_id,
      this.items,
      this.date,
      this.status,
      this.payment_code,
      this.order_key,
      this.order_total,
      this.order_currency,
      this.i18n,
      this.id,
      this.date_formatted,
      this.cart_items,
      this.total,
      this.user});

  factory OrderBean.fromJson(Map<String, dynamic> json) =>
      _$OrderBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBeanToJson(this);
}

@JsonSerializable()
class UserBean {
  num id;
  String login;
  String avatar;
  String avatar_url;
  String email;
  String url;

  UserBean(
      {this.id,
      this.login,
      this.avatar,
      this.avatar_url,
      this.email,
      this.url});

  factory UserBean.fromJson(Map<String, dynamic> json) =>
      _$UserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}

@JsonSerializable()
class Cart_itemsBean {
  num cart_item_id;
  String title;
  String image;
  String image_url;
  String price;
  List<String> terms;
  String price_formatted;

  Cart_itemsBean(
      {this.cart_item_id,
      this.title,
      this.image,
      this.price,
      this.terms,
      this.price_formatted,
      this.image_url});

  factory Cart_itemsBean.fromJson(Map<String, dynamic> json) =>
      _$Cart_itemsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$Cart_itemsBeanToJson(this);
}

@JsonSerializable()
class I18nBean {
  String order_key;
  String date;
  String status;
  String pending;
  String processing;
  String failed;
  @JsonKey(name: "on-hold")
  String on_hold;
  String refunded;
  String completed;
  String cancelled;
  String user;
  String order_items;
  String course_name;
  String course_price;
  String total;

  I18nBean(
      {this.order_key,
      this.date,
      this.status,
      this.pending,
      this.processing,
      this.failed,
      this.on_hold,
      this.refunded,
      this.completed,
      this.cancelled,
      this.user,
      this.order_items,
      this.course_name,
      this.course_price,
      this.total});

  factory I18nBean.fromJson(Map<String, dynamic> json) =>
      _$I18nBeanFromJson(json);

  Map<String, dynamic> toJson() => _$I18nBeanToJson(this);
}

@JsonSerializable()
class ItemsBean {
  String item_id;
  String price;

  ItemsBean({this.item_id, this.price});

  factory ItemsBean.fromJson(Map<String, dynamic> json) =>
      _$ItemsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsBeanToJson(this);
}
