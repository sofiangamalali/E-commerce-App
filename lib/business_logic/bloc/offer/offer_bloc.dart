// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/offer_model.dart';
import 'package:elhaga/Data/Repositories/offer_repo.dart';
import 'package:equatable/equatable.dart';
part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository _offerRepository;
  OfferBloc({required OfferRepository offerRepository})
      : _offerRepository = offerRepository,
        super(OfferLoading()) {
    on<LoadOffers>((event, emit) async {
      final offers = await _offerRepository.getAllOffers();
      if (offers.isNotEmpty) {
        emit(OfferLoaded(offers: offers));
      } else {
        emit(OfferError());
      }
    });
  }
}
