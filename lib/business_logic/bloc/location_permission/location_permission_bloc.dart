// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
part 'location_permission_event.dart';
part 'location_permission_state.dart';

class LocationPermissionBloc
    extends Bloc<LocationPermissionEvent, LocationPermissionState> {
  final storage = const FlutterSecureStorage();
  LocationPermissionBloc() : super(LocationStarted()) {
    on<RequestLocationPermission>((event, emit) async {
      emit(LocationLoading());
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        emit(LocationPermissionDeniedForEver());
      }
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission != LocationPermission.always ||
            locationPermission != LocationPermission.whileInUse) {
          if (await checkDeniedForFirstTime()) {
            emit(LocationPermissionDeniedTwice());
          } else {
            writeDeniedForFirstTime();
            emit(LocationPermissionDenied());
          }
        } else if (locationPermission == LocationPermission.deniedForever) {
          emit(LocationPermissionDeniedForEver());
        }
      } else {
        emit(LocationPermissionEnabled());
        add(CheckGpsService());
      }
    });

    on<CheckGpsService>((event, emit) async {
      emit(LocationLoading());
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationGpsServiceDisabled());
      } else {
        emit(LocationGpsServiceEnabled());
        add(GetCurrentLocation());
      }
    });
    on<OpenLocationPermission>((event, emit) async {
      await Geolocator.openAppSettings();
    });
    on<OpenGpsService>(
      (event, emit) async {
        await Geolocator.openLocationSettings();
      },
    );
    on<GetCurrentLocation>((event, emit) async {
      emit(LocationLoading());
      Position position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(
          location: LatLng(position.latitude, position.longitude)));
    });
  }
}
