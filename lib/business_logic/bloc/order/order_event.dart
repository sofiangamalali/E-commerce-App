part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class MakeOrder extends OrderEvent {
  final OrderModel order;
  const MakeOrder({required this.order});
  @override
  List<Object> get props => [order];
}

class GetOrders extends OrderEvent {}

class CancelOrder extends OrderEvent {
  final OrderModel order;
  const CancelOrder({required this.order});

  @override
  List<Object> get props => [order];
}
