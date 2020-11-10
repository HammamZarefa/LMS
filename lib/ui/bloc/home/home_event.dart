import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class FetchEvent extends HomeEvent {}
