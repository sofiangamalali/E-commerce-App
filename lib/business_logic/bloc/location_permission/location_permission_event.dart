part of 'location_permission_bloc.dart';

abstract class LocationPermissionEvent extends Equatable {
  const LocationPermissionEvent();

  @override
  List<Object> get props => [];
}

class RequestLocationPermission extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}

class OpenLocationPermission extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}

class OpenGpsService extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}

class CheckGpsService extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}

class GetCurrentLocation extends LocationPermissionEvent {
  @override
  List<Object> get props => [];
}
