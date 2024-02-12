import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/ui/screens/onboarding/category_selection_screen.dart';
import 'package:taazakhabar/ui/screens/onboarding/city_selection_screen.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      body: Center(
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
                  String username = _textController.text;
                  BlocProvider.of<OnboardingBloc>(context).add(NameEnteredEvent(username));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}