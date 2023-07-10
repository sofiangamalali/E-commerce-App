// ignore_for_file: must_be_immutable, no_logic_in_create_state
import 'package:elhaga/Data/Models/order_model.dart';
import 'package:elhaga/business_logic/bloc/cart/cart_bloc.dart';
import 'package:elhaga/business_logic/bloc/location/location_bloc.dart';
import 'package:elhaga/business_logic/bloc/location_permission/location_permission_bloc.dart';
import 'package:elhaga/business_logic/bloc/order/order_bloc.dart';
import 'package:elhaga/business_logic/bloc/settings/settings_bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:elhaga/presentation/widgets/custom_button.dart';
import 'package:elhaga/presentation/widgets/location/location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/radio_listtile_for_payment.dart';

class OrderScreen extends StatefulWidget {
  final double totalForCart;
  final Map cartItems;
  const OrderScreen(
      {this.cartItems = const {}, this.totalForCart = 0.0, super.key});

  @override
  State<OrderScreen> createState() =>
      _OrderScreenState(cartItems, totalForCart);
}

class _OrderScreenState extends State<OrderScreen> {
  final double totalForCart;
  final Map cartItems;
  _OrderScreenState(this.cartItems, this.totalForCart);
  final GlobalKey<FormState> _orderFormKey = GlobalKey();
  TextEditingController addressController = TextEditingController();

  String streetName = '';
  String buildingNumber = '';
  String floorNumber = '';
  String flatNumber = '';
  LatLng location = LatLng(0, 0);
  String selectedZone = '';
  String phoneNumber = '';
  double deliveryFee = 0;
  DateTime orderDate = DateTime.now();

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildTextField(
    String hintText,
    bool isNumber,
    ValueChanged<String> onChanged,
  ) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(isNumber ? 4 : 30),
          ],
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          textDirection: TextDirection.rtl,
          autofocus: false,
          cursorColor: Colors.teal[400],
          cursorHeight: 30,
          style: const TextStyle(
            fontSize: 18,
            height: 1.3,
          ),
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              fontSize: 16,
            ),
            labelText: hintText,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red[400]!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red[400]!),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'مطلوب';
            } else {
              return null;
            }
          },
          onChanged: onChanged),
    );
  }

  Widget _buildPhoneTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontSize: 18,
          height: 1.3,
        ),
        cursorColor: Colors.teal[400],
        cursorHeight: 30,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 16,
          ),
          labelText: 'رقم الهاتف',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.red[400]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.red[400]!),
          ),
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return 'أدخل رقم الهاتف';
          } else if (value.length < 11 || !value.startsWith('01')) {
            return 'أدخل رقم هاتف صحيح';
          }
          return null;
        },
        onChanged: (value) {
          phoneNumber = value;
        },
      ),
    );
  }

  Widget _buildDropDownMenuForZone(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 12,
                    ),
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                  hint: const Center(
                    child: Text(
                      'المنطقة',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        height: 1.3,
                      ),
                    ),
                  ),
                  elevation: 1,
                  icon: const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.teal,
                      size: 20,
                    ),
                  ),
                  items: state.settings.zones.keys
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'Cairo'),
                                )),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedZone = value.toString();
                    setState(() {
                      deliveryFee = double.parse(state.settings.zones[value]);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'أختر المنطقة';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildOrderButton() {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) async {
        if (state is OrderSent) {
          context.read<CartBloc>().add(ClearCart());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal[300],
              content: const Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  'تم الطلب بنجاح هنتواصل معاك عن طريق مكالمة أو عبر الواتساب',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              duration: const Duration(seconds: 3),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      listenWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        return CustomButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_orderFormKey.currentState!.validate()) {
                context.read<OrderBloc>().add(
                      MakeOrder(
                        order: OrderModel(
                          id: generateUniqueId(phoneNumber, orderDate),
                          streetName: streetName,
                          buildingNumber: buildingNumber,
                          floorNumber: floorNumber,
                          flatNumber: flatNumber,
                          location: location,
                          paymentMethod: 'نقداً',
                          phoneNumber: phoneNumber,
                          zone: selectedZone,
                          cartPrice:
                              double.parse(totalForCart.toStringAsFixed(2)),
                          deliveryFee: deliveryFee,
                          orderPrice: double.parse(
                              (totalForCart + deliveryFee).toStringAsFixed(2)),
                          orderDate: orderDate,
                          orderStatus: 'جديد',
                          cartItems: convertCartItemsToFireBaseMap(cartItems),
                          deliveryDate: orderDate.add(
                            const Duration(days: 1),
                          ),
                        ),
                      ),
                    );
              } else {
                return;
              }
            },
            title: state is OrderLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text('تنفيذ الطلب'));
      },
    );
  }

  Widget _buildLocationTextFieldWithButton(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: BlocConsumer<LocationBloc, LocationState>(
                listener: (context, state) {
                  if (state is LocationPickedUp) {
                    addressController.text = state.adress;
                    location = state.location;
                  }
                },
                listenWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, state) {
                  return TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'اختر الموقع';
                      } else {
                        return null;
                      }
                    },
                    enabled: false,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    decoration: InputDecoration(
                      hintText: 'أختر الموقع',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        height: 1,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.red[400]!),
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child:
                BlocConsumer<LocationPermissionBloc, LocationPermissionState>(
              listener: (context, state) {
                if (state is LocationGpsServiceDisabled) {
                  showAlertDialoge(
                    context,
                    'يريد التطبيق فتح خدمة الموقع',
                    () {
                      Navigator.of(context).pop();
                      context
                          .read<LocationPermissionBloc>()
                          .add(OpenGpsService());
                    },
                    false,
                  );
                }
                if (state is LocationLoaded) {
                  location = state.location;
                  _showLocationBottomSheet(context, state.location);
                }
              },
              listenWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    context
                        .read<LocationPermissionBloc>()
                        .add(RequestLocationPermission());
                    if (state is LocationPermissionDeniedForEver ||
                        state is LocationPermissionDeniedTwice) {
                      showAlertDialoge(
                        context,
                        'يريد التطبيق الأذن بالوصول الي موقعك',
                        () {
                          Navigator.of(context).pop();
                          context
                              .read<LocationPermissionBloc>()
                              .add(OpenLocationPermission());
                        },
                        false,
                      );
                    }
                  },
                  child: _buildLocationContainer(state is LocationLoading),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationBottomSheet(BuildContext context, LatLng currentLocation) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(children: [
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                return LoactionBottomSheet(
                    currentLocation: location,
                    pickedUpLocation:
                        state is LocationPickedUp ? state.location : location);
              },
            ),
          ]);
        });
  }

  Widget _buildOrderDetails(double amount) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'قيمة الطلب',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[900],
              ),
            ),
            Text(
              '${amount.toStringAsFixed(2)} ج.م',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryDetails(double amount) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'قيمة التوصيل',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[900],
                ),
              ),
              Text(
                '$amount ج.م',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildTotalOrderDetails(double amount) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${amount.toStringAsFixed(2)} ج.م',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  Widget _buildLocationContainer(bool isLodaing) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Colors.teal[300],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isLodaing
          ? Transform.scale(
              scale: 0.3,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 10,
              ),
            )
          : const Center(
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.white,
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'الطلب',
        isItemScreen: false,
        backgroundColor: Colors.white,
        withBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _orderFormKey,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _buildSectionTitle('العنوان'),
                const SizedBox(height: 20),
                _buildTextField(
                  'اسم الشارع',
                  false,
                  (value) {
                    setState(() {
                      streetName = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _buildTextField(
                        'رقم المبنى',
                        true,
                        (value) {
                          setState(() {
                            buildingNumber = value;
                          });
                        },
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(
                        'رقم الدور',
                        true,
                        (value) {
                          setState(() {
                            floorNumber = value;
                          });
                        },
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(
                        'رقم الشقة',
                        true,
                        (value) {
                          setState(() {
                            flatNumber = value;
                          });
                        },
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _buildDropDownMenuForZone(context),
                const SizedBox(height: 15),
                _buildLocationTextFieldWithButton(context),
                const SizedBox(height: 20),
                _buildPhoneTextField(),
                const SizedBox(height: 20),
                _buildSectionTitle('الدفع'),
                const SizedBox(height: 20),
                const RadioListTileForPayment(),
                const SizedBox(height: 20),
                _buildSectionTitle('تفاصيل الطلب'),
                const SizedBox(height: 20),
                _buildOrderDetails(widget.totalForCart),
                const SizedBox(height: 10),
                _buildDeliveryDetails(deliveryFee),
                const SizedBox(height: 10),
                Divider(color: Colors.grey[400], thickness: 2),
                const SizedBox(height: 10),
                _buildTotalOrderDetails(widget.totalForCart + deliveryFee),
                const SizedBox(height: 20),
                _buildOrderButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
