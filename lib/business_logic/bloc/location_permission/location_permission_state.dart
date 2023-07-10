part of 'location_permission_bloc.dart';

abstract class LocationPermissionState extends Equatable {
  const LocationPermissionState();

  @override
  List<Object> get props => [];
}

class LocationStarted extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationGpsServiceEnabled extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationGpsServiceDisabled extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationPermissionEnabled extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationPermissionDenied extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationPermissionDeniedTwice extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationPermissionDeniedForEver extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationPermissionState {
  final LatLng location;
  const LocationLoaded({required this.location});
  @override
  List<Object> get props => [location];
}

class LocationError extends LocationPermissionState {
  final String errorMsg;
  const LocationError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
