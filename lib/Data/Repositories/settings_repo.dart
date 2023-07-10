import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhaga/Data/Models/settings_model.dart' as settings_model;

class SettingsRepository {
  Future getSettings() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('settings').get();
      return querySnapshot.docs
          .map((doc) => settings_model.Settings.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
