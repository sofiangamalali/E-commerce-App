// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<PickUpLocation>((event, emit) {
      emit(LocationInitial());
      emit(LocationPickedUp(location: event.location, adress: event.adress));
    });
  }
}
