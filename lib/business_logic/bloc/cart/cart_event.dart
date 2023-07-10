part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvent {
  final Item item;
  const CartItemAdded(this.item);
  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends CartEvent {
  final Item item;
  const CartItemRemoved(this.item);
  @override
  List<Object> get props => [item];
}

class ClearCart extends CartEvent {
  @override
  List<Object> get props => [];
}
