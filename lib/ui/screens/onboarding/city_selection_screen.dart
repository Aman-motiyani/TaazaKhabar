import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/ui/screens/onboarding/category_selection_screen.dart';

import '../../../blocs/onboarding_bloc/onboarding_controller.dart';

class CityScreen extends StatelessWidget {
  final OnboardingBloc onboardingBloc; // Accept the OnboardingBloc instance as a parameter
  const CityScreen({Key? key, required this.onboardingBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Select City"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); }),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<OnboardingBloc, OnboardingState>(
            bloc: onboardingBloc,
            listener: (context, state) {
              if (state is CityNameUpdated) {
                print(state.cityName); // Print the city name when it's updated
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your city',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String city = _textController.text;
                    // controller.cityName.value = city;
                    onboardingBloc.add(CityNameChanged(city)); // Use the passed OnboardingBloc instance
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(onboardingBloc: onboardingBloc)));
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
