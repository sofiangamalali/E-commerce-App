import 'package:elhaga/Data/Models/order_model.dart';
import 'package:elhaga/business_logic/bloc/order/order_bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/order_status.dart';

class OrderDetalisScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetalisScreen({required this.order, super.key});
  Widget _buildItemDetalis() {
    List<Widget> itemColumn = [
      const Text(
        'المنتج',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ...getItemsName(order.cartItems)
          .map(
            (item) => Text(
              item,
              overflow: TextOverflow.ellipsis,
            ),
          )
          .toList(),
    ];
    List<Widget> quantityColumn = [
      const Text(
        'الكمية',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ...getItemsQuantity(order.cartItems).map((item) => Text(item)).toList(),
    ];
    List<Widget> priceColumn = [
      const Text(
        'السعر',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ...getItemsPrice(order.cartItems).map((item) => Text(item)).toList(),
    ];
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemColumn,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: quantityColumn),
              const SizedBox(
                width: 2,
              ),
              Column(children: priceColumn),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderDetalis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'المنطقة  :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'اسم الشارع :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'رقم المبنى :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'رقم الدور :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'رقم الشقة :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'رقم الهاتف :',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'طريقة الدفع :',
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            OrderStatus(orderStatus: order.orderStatus),
            Text(
              formatTheDate(order.orderDate),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              formatTheDate(order.deliveryDate),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.zone,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.streetName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.buildingNumber,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.floorNumber,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.flatNumber,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.phoneNumber,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              order.paymentMethod,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceDetalis() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Text(
                  'سعر المنتجات :',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'قيمة التوصيل :',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${order.cartPrice.toString()}  ج.م'),
                Text('${order.deliveryFee.toString()}  ج.م'),
              ],
            ),
          ],
        ),
        const Divider(
          color: Colors.teal,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'اجمالي الطلب :',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              '${order.orderPrice.toString()}  ج.م',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  List<String> getItemsName(Map cartitems) {
    List<String> names = [];
    for (var item in cartitems.entries) {
      String name = item.value['name'];
      names.add(name);
    }
    return names;
  }

  List<String> getItemsPrice(Map cartitems) {
    List<String> preices = [];
    for (var item in cartitems.entries) {
      String price = item.value['price'].toString();
      preices.add(price);
    }
    return preices;
  }

  List<String> getItemsQuantity(Map cartitems) {
    List<String> quantities = [];
    for (var item in cartitems.entries) {
      String quantity = item.value['quantity'].toString();
      quantities.add(quantity);
    }
    return quantities;
  }

  void _showAlertDialoge(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AlertDialog(
                  content: const Text(
                    'هل تريد الغاء الطلب ؟',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'الفاء',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        context
                            .read<OrderBloc>()
                            .add(CancelOrder(order: order));
                        context.read<OrderBloc>().add(GetOrders());
                      },
                      child: const Text(
                        'موافق',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        cancelOrder: () {
          _showAlertDialoge(context);
        },
        isOrderDetalisScreen:
            order.orderStatus == 'جديد' || order.orderStatus == 'جاري التوصيل'
                ? true
                : false,
        withBackButton: true,
        title: '#${order.id}',
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              children: [
                _buildOrderDetalis(),
                const Divider(color: Colors.teal),
                _buildItemDetalis(),
                const Divider(color: Colors.teal),
                _buildPriceDetalis()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
