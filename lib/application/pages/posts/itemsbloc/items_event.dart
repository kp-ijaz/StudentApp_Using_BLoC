part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemsRequestedEvent extends ItemsEvent {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends ItemsEvent {
  final ItemsEntity item;
  final int quantityToAdd;

  AddToCartEvent(this.item, {this.quantityToAdd = 1});

  @override
  List<Object> get props => [item, quantityToAdd];
}

class RemoveFromCartEvent extends ItemsEvent {
  final ItemsEntity item;
  final int quantityToRemove;

  RemoveFromCartEvent(this.item, {this.quantityToRemove = 1});

  @override
  List<Object> get props => [item, quantityToRemove];
}
