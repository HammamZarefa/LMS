import 'package:json_annotation/json_annotation.dart';

part 'UserPlansResponse.g.dart';

class UserPlansResponse {
  final List<UserPlansBean> plans;

  UserPlansResponse(
    this.plans,
  );

  UserPlansResponse.fromJsonArray(List json)
      : plans = json.map((i) => new UserPlansBean.fromJson(i)).toList();
}

@JsonSerializable()
class UserPlansBean {
  String ID;
  String id;
  String subscription_id;
  String name;
  String description;
  String confirmation;
  String expiration_number;
  String expiration_period;
  num initial_payment;
  num billing_amount;
  String cycle_number;
  String cycle_period;
  String billing_limit;
  num trial_amount;
  String trial_limit;
  String code_id;
  String startdate;
  String enddate;
  String course_number;
  String features;
  num used_quotas;
  num quotas_left;
  ButtonBean button;

  UserPlansBean(
      {this.ID,
      this.id,
      this.subscription_id,
      this.name,
      this.description,
      this.confirmation,
      this.expiration_number,
      this.expiration_period,
      this.initial_payment,
      this.billing_amount,
      this.cycle_number,
      this.cycle_period,
      this.billing_limit,
      this.trial_amount,
      this.trial_limit,
      this.code_id,
      this.startdate,
      this.enddate,
      this.course_number,
      this.used_quotas,
      this.quotas_left,
      this.button,
        this.features
      });

  factory UserPlansBean.fromJson(Map<String, dynamic> json) =>
      _$UserPlansBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlansBeanToJson(this);
}

@JsonSerializable()
class ButtonBean {
  String text;
  String url;

  ButtonBean({this.text, this.url});

  factory ButtonBean.fromJson(Map<String, dynamic> json) =>
      _$ButtonBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonBeanToJson(this);
}
