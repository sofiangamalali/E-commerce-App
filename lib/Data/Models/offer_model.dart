import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_model.dart';

class Offer extends Item {
  final bool isOffer;

  Offer({
    required this.isOffer,
    required String id,
    required String image,
    required String name,
    required String description,
    required double price,
    required int quantity,
  }) : super(
          id: id,
          image: image,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
        );
  static Offer fromSnapshot(DocumentSnapshot snap) {
    return Offer(
        description: snap['description'],
        id: snap['id'],
        image: snap['image'],
        name: snap['name'],
        price: double.parse(snap['price'].toString()),
        quantity: snap['quantity'],
        isOffer: snap['isoffer']);
  }
}
