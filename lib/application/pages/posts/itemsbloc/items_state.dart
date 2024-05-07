part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsStateLoading extends ItemsState {}

class ItemsStateLoaded extends ItemsState {
  // final List<ItemsEntity> items;
  // final Map<ItemsEntity, int> cartItems;

  // const ItemsStateLoaded({
  //   // required this.items,
  //   // required this.cartItems,
  // });

  // @override
  // List<Object?> get props => [
  //       items,
  //     ];
}

class ItemsUpdated extends ItemsState {}

class ItemsStateError extends ItemsState {
  final String message;

  const ItemsStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
