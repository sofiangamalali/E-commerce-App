part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationPickedUp extends LocationState {
  final LatLng location;
  final String adress;
  const LocationPickedUp({required this.location, required this.adress});
  @override
  List<Object> get props => [location];
}

class LocationError extends LocationState {
  final String errorMsg;
  const LocationError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
