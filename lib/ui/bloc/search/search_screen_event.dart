import 'package:meta/meta.dart';

@immutable
abstract class SearchScreenEvent {}

class FetchEvent extends SearchScreenEvent {}
class SearchEvent extends SearchScreenEvent {
  final String query;

  SearchEvent(this.query);
}
