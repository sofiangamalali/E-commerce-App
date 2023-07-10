part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoaded extends SettingsState {
  final Settings settings;
  const SettingsLoaded({required this.settings});
  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  @override
  List<Object> get props => [];
}
