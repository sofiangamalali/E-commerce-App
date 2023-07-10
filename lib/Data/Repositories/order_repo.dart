import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhaga/Data/Models/order_model.dart';

class OrderRepository {
  Future<bool> sendOrder(OrderModel order) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(order.id)
          .set(OrderModel.orderData(order));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<OrderModel>> getAllOrdersById(List ordersId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where(FieldPath.documentId, whereIn: ordersId)
          .get();
      return querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> cancelOrder(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(id)
          .update({'orderStatus': 'ملغي'});

      return true;
    } catch (e) {
      return false;
    }
  }
}
