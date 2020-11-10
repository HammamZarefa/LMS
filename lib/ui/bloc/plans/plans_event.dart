import 'package:meta/meta.dart';

@immutable
abstract class PlansEvent {}

class FetchEvent extends PlansEvent {}

class SelectPlan extends PlansEvent{
  final int planId;

  SelectPlan(this.planId);
}
