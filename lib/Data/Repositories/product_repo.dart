import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhaga/Data/Models/product_model.dart';

class ProductRepository {
  Future<List<Product>> getAllProducts() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    } catch (e) {
      return [];
    }
  }
}
