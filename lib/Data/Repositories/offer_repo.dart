import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhaga/Data/Models/offer_model.dart';

class OfferRepository {
  Future<List<Offer>> getAllOffers() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('offers').get();
      return snapshot.docs.map((doc) => Offer.fromSnapshot(doc)).toList();
    } catch (e) {
      return [];
    }
  }
}
