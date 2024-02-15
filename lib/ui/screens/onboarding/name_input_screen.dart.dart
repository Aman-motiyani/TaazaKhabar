import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taazakhabar/blocs/onboarding_bloc/onboarding_controller.dart';
import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/ui/screens/onboarding/city_selection_screen.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Name"),
      ),
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is NameUpdated) {
            // Print a message when the name is updated/saved successfully
            print('Name saved successfully: ${state.name}');
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String name = _textController.text;
                    // controller.name.value = name;
                    BlocProvider.of<OnboardingBloc>(context).add(NameChanged(name));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen(onboardingBloc: OnboardingBloc(),)));
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
