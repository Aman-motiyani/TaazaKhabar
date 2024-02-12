import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/user_model.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  UserProfile userProfile = UserProfile(username: '', city: '', categories: []);

  OnboardingBloc() : super(NameScreenState()) {
    on<NameEnteredEvent>(_onNameEntered);
    on<CityEnteredEvent>(_onCityEntered);
    on<CategorySelectedEvent>(_onCategorySelected);
  }

  Stream<OnboardingState> _onNameEntered(NameEnteredEvent event, Emitter<OnboardingState> emit) async* {
    userProfile = UserProfile(username: event.username, city: '', categories: []);
    yield CityScreenState();
  }

  Stream<OnboardingState> _onCityEntered(CityEnteredEvent event, Emitter<OnboardingState> emit) async* {
    userProfile = UserProfile(username: userProfile.username, city: event.city, categories: []);
    yield CategoryScreenState();
  }

  Stream<OnboardingState> _onCategorySelected(CategorySelectedEvent event, Emitter<OnboardingState> emit) async* {
    userProfile = UserProfile(username: userProfile.username, city: userProfile.city, categories: event.categories);
    yield ProfileUpdatedState();
  }
}


