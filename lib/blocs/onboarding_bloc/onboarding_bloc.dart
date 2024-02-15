import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  String name = '';
  List<String> selectedCategories = [];
  String cityName = '';

  OnboardingBloc() : super(OnboardingInitial()) {
    // Register event handlers for each event
    on<NameChanged>((event, emit) {
      name = event.name;
      emit(DataLoaded(name, selectedCategories, cityName));
    });

    on<CategorySelected>((event, emit) {
      if (selectedCategories.contains(event.category)) {
        selectedCategories.remove(event.category);
      } else {
        selectedCategories.add(event.category);
      }
      emit(DataLoaded(name, selectedCategories, cityName));
    });

    on<CityNameChanged>((event, emit) {
      cityName = event.cityName;
      emit(DataLoaded(name, selectedCategories, cityName));
    });

    on<FetchInitialData>((event, emit) {
      emit(DataLoaded(name, selectedCategories, cityName));
    });
  }

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    // This method is empty because event handlers are registered using `on<Event>` method
  }
}
