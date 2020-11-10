import 'package:masterstudy_app/data/models/purchase/UserPlansResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlansState {}

class InitialPlansState extends PlansState {}

class LoadedPlansState extends PlansState {
  final List<UserPlansBean> plans;

  LoadedPlansState(this.plans);
}

