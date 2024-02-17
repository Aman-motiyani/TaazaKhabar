import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      emit(CategoriesUpdated(selectedCategories));
    });

    on<CityNameChanged>((event, emit) {
      cityName = event.cityName;
      emit(DataLoaded(name, selectedCategories, cityName));
    });

    on<FetchInitialData>((event, emit) {
      emit(DataLoaded(name, selectedCategories, cityName));
    });
  }

  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    print('loading pref ${name}');
    cityName = prefs.getString('cityName') ?? '';
    selectedCategories = prefs.getStringList('selectedCategories') ?? [];
    emit(DataLoaded(name, selectedCategories, cityName));
  }

  // Save data to shared preferences
  Future<void> saveToSharedPreferences({String? Uname}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', Uname ?? name);
    print('Setting pref ${name}');
    prefs.setString('cityName', cityName);
    prefs.setStringList('selectedCategories', selectedCategories);
  }

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
  }
}
