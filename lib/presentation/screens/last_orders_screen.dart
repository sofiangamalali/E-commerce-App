// ignore_for_file: prefer_const_constructors

import 'package:elhaga/business_logic/bloc/order/order_bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:elhaga/presentation/screens/order_detalis_screen.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:elhaga/presentation/widgets/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Models/order_model.dart';

class LastOredersScreen extends StatefulWidget {
  static const String screenRoute = 'LastOrdersScreen';
  const LastOredersScreen({super.key});

  @override
  State<LastOredersScreen> createState() => _LastOredersScreenState();
}

class _LastOredersScreenState extends State<LastOredersScreen> {
  Widget _buildEmptyScreen() {
    return Center(
      child: Text(
        'لا توجد طلبات سابقة',
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal[300]!),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderDetalisScreen(
                    order: order,
                  )));
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'رقم الطلب :',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'حالة الطلب :',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'تاريخ الطلب :',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'تاريخ التوصيل :',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'المجموع :',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '#${order.id}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  OrderStatus(orderStatus: order.orderStatus),
                  Text(
                    formatTheDate(order.orderDate),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    formatTheDate(order.deliveryDate),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${order.orderPrice} ج.م',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrders());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'الطلبات السابقة',
        backgroundColor: Colors.white,
        withBackButton: true,
        isLastOrderScreen: true,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            List<Widget> orders = state.ordersList
                .map((order) => _buildOrderCard(context, order))
                .toList();
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(children: orders.reversed.toList()),
            );
          } else if (state is OrderLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.teal,
            ));
          } else {
            return _buildEmptyScreen();
          }
        },
      ),
    );
  }
}
