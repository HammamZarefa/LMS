// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdersResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBean _$OrderBeanFromJson(Map<String, dynamic> json) {
  return OrderBean(
    user_id: json['user_id'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['date'] as String,
    status: json['status'] as String,
    payment_code: json['payment_code'] as String,
    order_key: json['order_key'] as String,
    order_total: json['_order_total'] as String,
    order_currency: json['_order_currency'] as String,
    i18n: json['i18n'] == null
        ? null
        : I18nBean.fromJson(json['i18n'] as Map<String, dynamic>),
    id: json['id'] as num,
    date_formatted: json['date_formatted'] as String,
    cart_items: (json['cart_items'] as List)
        ?.map((e) => e == null
            ? null
            : Cart_itemsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    total: json['total'] as String,
    user: json['user'] == null
        ? null
        : UserBean.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderBeanToJson(OrderBean instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'items': instance.items,
      'date': instance.date,
      'status': instance.status,
      'payment_code': instance.payment_code,
      'order_key': instance.order_key,
      '_order_total': instance.order_total,
      '_order_currency': instance.order_currency,
      'i18n': instance.i18n,
      'id': instance.id,
      'date_formatted': instance.date_formatted,
      'cart_items': instance.cart_items,
      'total': instance.total,
      'user': instance.user,
    };

UserBean _$UserBeanFromJson(Map<String, dynamic> json) {
  return UserBean(
    id: json['id'] as num,
    login: json['login'] as String,
    avatar: json['avatar'] as String,
    avatar_url: json['avatar_url'] as String,
    email: json['email'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'avatar': instance.avatar,
      'avatar_url': instance.avatar_url,
      'email': instance.email,
      'url': instance.url,
    };

Cart_itemsBean _$Cart_itemsBeanFromJson(Map<String, dynamic> json) {
  return Cart_itemsBean(
    cart_item_id: json['cart_item_id'] as num,
    title: json['title'] as String,
    image: json['image'] as String,
    price: json['price'] as String,
    terms: (json['terms'] as List)?.map((e) => e as String)?.toList(),
    price_formatted: json['price_formatted'] as String,
    image_url: json['image_url'] as String,
  );
}

Map<String, dynamic> _$Cart_itemsBeanToJson(Cart_itemsBean instance) =>
    <String, dynamic>{
      'cart_item_id': instance.cart_item_id,
      'title': instance.title,
      'image': instance.image,
      'image_url': instance.image_url,
      'price': instance.price,
      'terms': instance.terms,
      'price_formatted': instance.price_formatted,
    };

I18nBean _$I18nBeanFromJson(Map<String, dynamic> json) {
  return I18nBean(
    order_key: json['order_key'] as String,
    date: json['date'] as String,
    status: json['status'] as String,
    pending: json['pending'] as String,
    processing: json['processing'] as String,
    failed: json['failed'] as String,
    on_hold: json['on-hold'] as String,
    refunded: json['refunded'] as String,
    completed: json['completed'] as String,
    cancelled: json['cancelled'] as String,
    user: json['user'] as String,
    order_items: json['order_items'] as String,
    course_name: json['course_name'] as String,
    course_price: json['course_price'] as String,
    total: json['total'] as String,
  );
}

Map<String, dynamic> _$I18nBeanToJson(I18nBean instance) => <String, dynamic>{
      'order_key': instance.order_key,
      'date': instance.date,
      'status': instance.status,
      'pending': instance.pending,
      'processing': instance.processing,
      'failed': instance.failed,
      'on-hold': instance.on_hold,
      'refunded': instance.refunded,
      'completed': instance.completed,
      'cancelled': instance.cancelled,
      'user': instance.user,
      'order_items': instance.order_items,
      'course_name': instance.course_name,
      'course_price': instance.course_price,
      'total': instance.total,
    };

ItemsBean _$ItemsBeanFromJson(Map<String, dynamic> json) {
  return ItemsBean(
    item_id: json['item_id'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$ItemsBeanToJson(ItemsBean instance) => <String, dynamic>{
      'item_id': instance.item_id,
      'price': instance.price,
    };
