import 'package:blocapp/domain/entities/post_entity.dart';
import 'package:blocapp/domain/usecases/items_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsRequestedEvent>((event, emit) async {
      try {
        items = await ItemsUsecase().getItemsFromDataSource();
        emit(ItemsStateLoaded());
      } catch (e) {
        emit(ItemsStateError(message: e.toString()));
      }
    });

    on<AddToCartEvent>((event, emit) {
      final currentState = state;
      //  final  = Map<ItemsEntity, int>.from(currentState.cartItems);

      updatedCart[event.item] =
          (updatedCart[event.item] ?? 0) + event.quantityToAdd;

      emit(ItemsStateLoaded());
      emit(ItemsUpdated());
      // if (currentState is ItemsStateLoaded) {

      // }
    });

    on<RemoveFromCartEvent>((event, emit) {
      final currentState = state;
      if (currentState is ItemsStateLoaded || state is ItemsUpdated) {
        if (updatedCart.containsKey(event.item)) {
          updatedCart[event.item] =
              (updatedCart[event.item] ?? 0) - event.quantityToRemove;

          if (updatedCart[event.item]! <= 0) {
            updatedCart.remove(event.item);
          }
          emit(ItemsStateLoaded());
        }
      }
    });
  }
  Map<ItemsEntity, int> updatedCart = {};
  List<ItemsEntity> items = [];
}
