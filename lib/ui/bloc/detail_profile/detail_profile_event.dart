import 'package:masterstudy_app/data/models/account.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailProfileEvent {}

class FetchDetailProfile extends DetailProfileEvent{
  final int id;

  FetchDetailProfile(this.id);
}

class LoadDetailProfile extends DetailProfileEvent{
}
