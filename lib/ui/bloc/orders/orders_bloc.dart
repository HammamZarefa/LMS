import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/purchase_repository.dart';

import './bloc.dart';

@provide
class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final PurchaseRepository _repository;

  OrdersBloc(this._repository);

  @override
  OrdersState get initialState => InitialOrdersState();

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is FetchEvent) {
      try {
        var orders = await _repository.getOrders();
        if(orders!=null && orders.isNotEmpty) {
          yield LoadedOrdersState(orders);
        }else yield EmptyOrdersState();
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
