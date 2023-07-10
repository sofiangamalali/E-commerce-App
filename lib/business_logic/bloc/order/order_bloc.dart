// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/order_model.dart';
import 'package:elhaga/Data/Repositories/order_repo.dart';
import 'package:elhaga/helper.dart';
import 'package:equatable/equatable.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository;
  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<MakeOrder>((event, emit) async {
      emit(OrderLoading());
      await Future.delayed(const Duration(seconds: 3));
      bool isOrderSent = await orderRepository.sendOrder(event.order);
      List<String> orderIdList = await readOrdersIdFromStorage();
      orderIdList.add(event.order.id);
      writeIdOrderIdToStorage(orderIdList);
      if (isOrderSent) {
        emit(OrderSent());
      } else {
        emit(OrderError());
      }
    });
    on<GetOrders>((event, emit) async {
      emit(OrderLoading());
      List<String> ordersId = await readOrdersIdFromStorage();

      List<OrderModel> orders =
          await orderRepository.getAllOrdersById(ordersId);
      if (orders.isNotEmpty) {
        emit(OrderLoaded(ordersList: orders));
      } else {
        emit(OrdersEmpty());
      }
    });
    on<CancelOrder>((event, emit) async {
      emit(OrderLoading());
      await orderRepository.cancelOrder(event.order.id);
    });
  }
}
