part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class PickUpLocation extends LocationEvent {
  final String adress;
  final LatLng location;
  const PickUpLocation({required this.adress, required this.location});
  @override
  List<Object> get props => [location, adress];
}
