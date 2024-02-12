part of 'onboarding_bloc.dart';

@immutable
// onboarding_events.dart
abstract class OnboardingEvent {}

class NameEnteredEvent extends OnboardingEvent {
  final String username;

  NameEnteredEvent(this.username);
}

class CityEnteredEvent extends OnboardingEvent {
  final String city;

  CityEnteredEvent(this.city);
}

class CategorySelectedEvent extends OnboardingEvent {
  final List<String> categories;

  CategorySelectedEvent(this.categories);
}

// settings_events.dart
abstract class SettingsEvent {}

class ProfileUpdateEvent extends SettingsEvent {
  final String username;
  final String city;
  final List<String> categories;

  ProfileUpdateEvent(this.username, this.city, this.categories);
}
