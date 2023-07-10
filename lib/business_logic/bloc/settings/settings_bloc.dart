// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/settings_model.dart';
import 'package:elhaga/Data/Repositories/settings_repo.dart';
import 'package:equatable/equatable.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  SettingsBloc({required this.settingsRepository}) : super(SettingsInitial()) {
    on<LoadSettings>((event, emit) async {
      emit(SettingsLoading());
      List settigns = await settingsRepository.getSettings();
      if (settigns.isNotEmpty) {
        emit(SettingsLoaded(settings: settigns.first));
      } else {
        emit(SettingsError());
      }
    });
  }
}
