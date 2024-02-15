part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class NameChanged extends OnboardingEvent  {
  final String name;

  NameChanged(this.name);

  List<Object?> get props => [name];
}

class CategorySelected extends OnboardingEvent {
  final String category;

  CategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

class FetchInitialData extends OnboardingEvent {}


class CityNameChanged extends OnboardingEvent {
  final String cityName;

  CityNameChanged(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
