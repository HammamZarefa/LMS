import 'package:meta/meta.dart';

@immutable
abstract class FavoritesEvent {}

class FetchFavorites extends FavoritesEvent {}

class DeleteEvent extends FavoritesEvent {
  final int courseId;

  DeleteEvent(this.courseId);
}
