import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class OrderModel {
  final String id;
  final String streetName;
  final String buildingNumber;
  final String floorNumber;
  final String flatNumber;
  final String zone;
  final String phoneNumber;
  final String paymentMethod;
  final String orderStatus;
  final LatLng location;
  final double cartPrice;
  final double deliveryFee;
  final double orderPrice;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final Map cartItems;

  OrderModel({
    required this.id,
    required this.streetName,
    required this.buildingNumber,
    required this.floorNumber,
    required this.flatNumber,
    required this.location,
    required this.paymentMethod,
    required this.phoneNumber,
    required this.zone,
    required this.cartPrice,
    required this.deliveryFee,
    required this.orderPrice,
    required this.orderDate,
    required this.orderStatus,
    required this.cartItems,
    required this.deliveryDate,
  });
  static Map<String, dynamic> orderData(OrderModel order) {
    return {
      'id': order.id,
      'streetName': order.streetName,
      'buildingNumber': order.buildingNumber,
      'floorNumber': order.floorNumber,
      'flatNumber': order.flatNumber,
      'location': GeoPoint(order.location.latitude, order.location.longitude),
      'paymentMethod': order.paymentMethod,
      'phoneNumber': order.phoneNumber,
      'zone': order.zone,
      'cartPrice': order.cartPrice,
      'deliveryFee': order.deliveryFee,
      'orderPrice': order.orderPrice,
      'orderDate': order.orderDate,
      'deliveryDate': order.deliveryDate,
      'orderStatus': order.orderStatus,
      'cartItems': order.cartItems,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    GeoPoint geoPoint = snap['location'];
    double latitude = geoPoint.latitude;
    double longitude = geoPoint.longitude;
    return OrderModel(
      id: snap.id,
      streetName: snap['streetName'],
      buildingNumber: snap['buildingNumber'],
      floorNumber: snap['floorNumber'],
      flatNumber: snap['flatNumber'],
      location: LatLng(latitude, longitude),
      paymentMethod: snap['paymentMethod'],
      phoneNumber: snap['phoneNumber'],
      zone: snap['zone'],
      cartPrice: double.parse(snap['cartPrice'].toString()),
      deliveryFee: double.parse(snap['deliveryFee'].toString()),
      orderPrice: double.parse(snap['orderPrice'].toString()),
      orderDate: snap['orderDate'].toDate(),
      orderStatus: snap['orderStatus'],
      cartItems: snap['cartItems'],
      deliveryDate: snap['deliveryDate'].toDate(),
    );
  }
}
