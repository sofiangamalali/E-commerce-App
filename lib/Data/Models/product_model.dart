import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_model.dart';

class Product extends Item {
  final String previuosPrice;
  final bool isRecommended;

  Product({
    required String id,
    required String image,
    required String name,
    required String description,
    required this.previuosPrice,
    required double price,
    required int quantity,
    required this.isRecommended,
  }) : super(
            description: description,
            id: id,
            image: image,
            name: name,
            price: price,
            quantity: quantity);
  factory Product.fromSnapshot(DocumentSnapshot snap) {
    return Product(
        id: snap['id'],
        image: snap['image'],
        name: snap['name'],
        description: snap['description'],
        previuosPrice: snap['previuosPrice'],
        price: double.parse(snap['price'].toString()),
        quantity: snap['quantity'],
        isRecommended: snap['isRecommended']);
  }
}
