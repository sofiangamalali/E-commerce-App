import 'package:cloud_firestore/cloud_firestore.dart';

class Settings {
  bool newUpdate;
  bool appIssue;
  Map zones;
  String contactPhone;
  String appIssueText;
  String newUpdateText;
  Settings({
    required this.appIssueText,
    required this.newUpdateText,
    required this.appIssue,
    required this.newUpdate,
    required this.zones,
    required this.contactPhone,
  });
  factory Settings.fromSnapshot(DocumentSnapshot snapshot) {
    return Settings(
      appIssue: snapshot['appIssue'],
      contactPhone: snapshot['contactPhone'],
      newUpdate: snapshot['newUpdate'],
      appIssueText: snapshot['appIssueText'],
      newUpdateText: snapshot['newUpdateText'],
      zones: snapshot['zones'],
    );
  }
}
