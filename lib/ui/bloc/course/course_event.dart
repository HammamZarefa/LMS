import 'package:meta/meta.dart';

@immutable
abstract class CourseEvent {}

class FetchEvent extends CourseEvent {
  final int courseId;

  FetchEvent(this.courseId);
}

class PaymentSelectedEvent extends CourseEvent {
  final int selectedPaymentId;
  final int courseId;

  PaymentSelectedEvent(this.selectedPaymentId, this.courseId);
}

class DeleteFromFavorite extends CourseEvent {
  final int courseId;

  DeleteFromFavorite(this.courseId);
}

class AddToFavorite extends CourseEvent {
  final int courseId;

  AddToFavorite(this.courseId);
}

class AddToCart extends CourseEvent {
  final int courseId;

  AddToCart(this.courseId);
}

class UsePlan extends CourseEvent {
  final int courseId;

  UsePlan(this.courseId);
}
