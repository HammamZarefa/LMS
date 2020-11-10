import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/purchase_repository.dart';
import './bloc.dart';

@provide
class PlansBloc extends Bloc<PlansEvent, PlansState> {

  final PurchaseRepository _repository;

  PlansBloc(this._repository);

  @override
  PlansState get initialState => InitialPlansState();

  @override
  Stream<PlansState> mapEventToState(
    PlansEvent event,
  ) async* {
    if(event is FetchEvent){
     var response = await  _repository.getPlans();
     yield LoadedPlansState(response);
    }
  }
}
