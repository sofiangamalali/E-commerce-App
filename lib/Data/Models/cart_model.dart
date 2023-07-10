import 'package:elhaga/Data/Models/item_model.dart';

import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final Map<Item, Map<String, dynamic>> items;

  const Cart({this.items = const <Item, Map<String, dynamic>>{}});

  double getTotalPrice() {
    double totalPrice = 0;
    items.forEach((item, itemData) {
      final totalItemPrice = itemData['totalPrice'] as double;
      totalPrice += totalItemPrice;
    });
    return totalPrice;
  }

  int getCount() {
    int count = 0;
    items.forEach((product, itemData) {
      final itemCount = itemData['quantity'] as int;
      count += itemCount;
    });
    return count;
  }

  bool checkProductStock(Item item, Map<Item, Map<String, dynamic>> items) {
    if (item.quantity == 0) {
      return false;
    } else if (items.containsKey(item)) {
      final itemData = items[item];
      int productQuantityInCart = itemData!['quantity'];
      if (productQuantityInCart < item.quantity) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  List<Object?> get props => [items];
}
