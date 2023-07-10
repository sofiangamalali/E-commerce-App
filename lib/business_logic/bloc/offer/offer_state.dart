part of 'offer_bloc.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

class OfferLoading extends OfferState {}

class OfferLoaded extends OfferState {
  final List<Offer> offers;

  const OfferLoaded({this.offers = const <Offer>[]});

  @override
  List<Object> get props => [offers];
}

class OfferError extends OfferState {}
