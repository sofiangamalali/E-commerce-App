import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String url = 'SettingsScreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.white,
        title: 'الإعدادات',
        isItemScreen: false,
      ),
      body: Center(
        child: Text('text'),
      ),
    );
  }
}
