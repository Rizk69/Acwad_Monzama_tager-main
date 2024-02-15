part of 'app_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class AppChangeModeState extends ThemeState {}

class GetOfflineDataLoadingState extends ThemeState {}
class GetOfflineDataSuccessState extends ThemeState {}
class GetOfflineDataErrorState extends ThemeState {
  final String error ;

  GetOfflineDataErrorState(this.error);
}
