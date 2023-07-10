part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSent extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> ordersList;
  const OrderLoaded({required this.ordersList});
  @override
  List<Object> get props => [ordersList];
}

class OrderError extends OrderState {}

class OrderCanceld extends OrderState {}

class OrdersEmpty extends OrderState {}
