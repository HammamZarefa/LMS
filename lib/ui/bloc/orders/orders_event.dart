import 'package:meta/meta.dart';

@immutable
abstract class OrdersEvent {}

class FetchEvent extends OrdersEvent{}