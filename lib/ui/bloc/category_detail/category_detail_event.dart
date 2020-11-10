import 'package:meta/meta.dart';

@immutable
abstract class CategoryDetailEvent {}

class FetchEvent extends CategoryDetailEvent {
    final int categoryId;

    FetchEvent(this.categoryId);
}