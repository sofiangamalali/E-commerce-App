// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/item_model.dart';
import 'package:equatable/equatable.dart';
import '../../../Data/Models/cart_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>((event, emit) async {
      emit(const CartLoaded());
    });
    on<CartItemAdded>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        final Map<Item, Map<String, dynamic>> updatedItems =
            Map.from(state.cart.items);
        if (updatedItems.containsKey(event.item)) {
          final itemData = updatedItems[event.item];
          final quantity = itemData!['quantity'] as int;
          final totalPrice = itemData['totalPrice'] as double;
          updatedItems[event.item] = {
            'quantity': quantity + 1,
            'totalPrice': totalPrice + event.item.price,
          };

          emit(CartLoading());
          emit(
            CartLoaded(
              cart: Cart(items: updatedItems),
            ),
          );
        } else {
          updatedItems[event.item] = {
            'quantity': 1,
            'totalPrice': event.item.price,
          };
          emit(
            CartLoaded(
              cart: Cart(items: updatedItems),
            ),
          );
        }
      }
    });
    on<CartItemRemoved>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;

        if (state.cart.items.containsKey(event.item)) {
          final Map<Item, Map<String, dynamic>> updatedItems =
              Map.from(state.cart.items);
          final itemData = updatedItems[event.item];
          final quantity = itemData!['quantity'] as int;
          final totalPrice = itemData['totalPrice'] as double;
          if (quantity > 1) {
            updatedItems[event.item] = {
              'quantity': quantity - 1,
              'totalPrice': totalPrice - event.item.price,
            };
          } else {
            updatedItems.remove(event.item);
          }
          emit(CartLoading());
          emit(
            CartLoaded(
              cart: Cart(items: updatedItems),
            ),
          );
        }
      }
    });
    on<ClearCart>((event, emit) {
      if (state is CartLoaded) {
        Map<Item, Map<String, dynamic>> clreadMap = {};
        emit(CartLoaded(cart: Cart(items: clreadMap)));
      }
    });
  }
}
