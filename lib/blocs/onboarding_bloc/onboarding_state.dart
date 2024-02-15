part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class NameUpdated extends OnboardingState {
  final String name;

  NameUpdated(this.name);
}

class CategoriesUpdated extends OnboardingState {
  final List<String> selectedCategories;

  CategoriesUpdated(this.selectedCategories);
}

class CityNameUpdated extends OnboardingState {
  final String cityName;

  CityNameUpdated(this.cityName);
}

class DataLoaded extends OnboardingState{
  final String name;
  final List<String> selectedCategories;
  final String cityName;

  DataLoaded(this.name,this.selectedCategories,this.cityName);

  @override
  List<Object> get props => [name,selectedCategories,cityName];
}
