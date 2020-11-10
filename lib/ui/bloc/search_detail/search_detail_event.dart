import 'package:meta/meta.dart';

@immutable
abstract class SearchDetailEvent {}

class FetchEvent extends SearchDetailEvent {
  final String query;

  FetchEvent(this.query);
}
