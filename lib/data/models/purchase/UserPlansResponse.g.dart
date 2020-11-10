// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPlansResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlansBean _$UserPlansBeanFromJson(Map<String, dynamic> json) {
  return UserPlansBean(
    ID: json['ID'] as String,
    id: json['id'] as String,
    subscription_id: json['subscription_id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    confirmation: json['confirmation'] as String,
    expiration_number: json['expiration_number'] as String,
    expiration_period: json['expiration_period'] as String,
    initial_payment: json['initial_payment'] as num,
    billing_amount: json['billing_amount'] as num,
    cycle_number: json['cycle_number'] as String,
    cycle_period: json['cycle_period'] as String,
    billing_limit: json['billing_limit'] as String,
    trial_amount: json['trial_amount'] as num,
    trial_limit: json['trial_limit'] as String,
    code_id: json['code_id'] as String,
    startdate: json['startdate'] as String,
    enddate: json['enddate'] as String,
    course_number: json['course_number'] as String,
    used_quotas: json['used_quotas'] as num,
    quotas_left: json['quotas_left'] as num,
    button: json['button'] == null
        ? null
        : ButtonBean.fromJson(json['button'] as Map<String, dynamic>),
    features: json['features'] as String,
  );
}

Map<String, dynamic> _$UserPlansBeanToJson(UserPlansBean instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'id': instance.id,
      'subscription_id': instance.subscription_id,
      'name': instance.name,
      'description': instance.description,
      'confirmation': instance.confirmation,
      'expiration_number': instance.expiration_number,
      'expiration_period': instance.expiration_period,
      'initial_payment': instance.initial_payment,
      'billing_amount': instance.billing_amount,
      'cycle_number': instance.cycle_number,
      'cycle_period': instance.cycle_period,
      'billing_limit': instance.billing_limit,
      'trial_amount': instance.trial_amount,
      'trial_limit': instance.trial_limit,
      'code_id': instance.code_id,
      'startdate': instance.startdate,
      'enddate': instance.enddate,
      'course_number': instance.course_number,
      'features': instance.features,
      'used_quotas': instance.used_quotas,
      'quotas_left': instance.quotas_left,
      'button': instance.button,
    };

ButtonBean _$ButtonBeanFromJson(Map<String, dynamic> json) {
  return ButtonBean(
    text: json['text'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ButtonBeanToJson(ButtonBean instance) =>
    <String, dynamic>{
      'text': instance.text,
      'url': instance.url,
    };
