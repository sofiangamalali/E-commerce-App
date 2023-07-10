// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'Data/Models/product_model.dart';

const storage = FlutterSecureStorage();

String generateUniqueId(String phoneNumber, DateTime timestamp) {
  String combinedString = '$phoneNumber${timestamp.toString()}';

  var bytes = utf8.encode(combinedString);
  var hash = md5.convert(bytes);
  String hashString = hash.toString();
  Random random = Random();
  String numericString = hashString.replaceAll(
      RegExp('[^0-9]'), (random.nextInt(9) + 1).toString());
  return numericString.toString().substring(0, 10);
}

void writeDeniedForFirstTime() async {
  await storage.write(key: 'denied', value: '1');
}

Future<bool> checkDeniedForFirstTime() async {
  return await storage.containsKey(key: 'denied');
}

void writeIdOrderIdToStorage(List<String> myList) async {
  final listString = myList.join(',');
  await storage.write(key: 'orderIds', value: listString);
}

Future<List<String>> readOrdersIdFromStorage() async {
  if (await storage.containsKey(key: 'orderIds')) {
    final listString = await storage.read(key: 'orderIds');
    final ordersId = listString!.split(',');
    return ordersId;
  } else {
    return [];
  }
}

void updateFavoriteList(List<String> myList) async {
  final listString = myList.join(',');
  await storage.write(key: 'FavList', value: listString);
}

Future<List<String>> readItemsFromFavoriteList() async {
  if (await storage.containsKey(key: 'FavList')) {
    final listString = await storage.read(key: 'FavList');
    final ordersId = listString!.split(',');
    return ordersId;
  } else {
    return [];
  }
}

String formatTheDate(DateTime date) {
  return '${date.year}-${date.month}-${date.day}';
}

void openWhatsapp(
    {required BuildContext context, required String number}) async {
  var phoneNumber = number;
  var whatsappURlAndroid = "whatsapp://send?phone=$phoneNumber";
  var whatsappURLIos = "https://wa.me/$phoneNumber";
  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('حدث خطأ ما'),
        backgroundColor: Colors.teal[100],
      ));
    }
  } else {
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      await launchUrl(
        Uri.parse(whatsappURLIos),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

Map convertCartItemsToFireBaseMap(Map cartItems) {
  Map<String, dynamic> convertedMap = {};
  cartItems.forEach((item, data) {
    convertedMap[item.id] = {
      'quantity': data['quantity'],
      'type': item is Product ? 'Product' : 'Offer',
      'name': item.name,
      'price': item.price * data['quantity'],
    };
  });
  return convertedMap;
}

void showAlertDialoge(BuildContext context, String tilte,
    VoidCallback yesButtonFunction, bool withoutCancelButton) {
  showDialog(
      barrierDismissible: withoutCancelButton ? false : true,
      context: context,
      builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: AlertDialog(
                title: Text(
                  withoutCancelButton ? 'تم الطلب بنجاح' : 'الموقع',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  tilte,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                actions: <Widget>[
                  !withoutCancelButton
                      ? TextButton(
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
                        )
                      : Container(),
                  TextButton(
                    onPressed: yesButtonFunction,
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
