import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/ui/screens/home/nav.dart';
import 'package:taazakhabar/ui/screens/home/pages/fav_screen.dart';
import 'package:taazakhabar/ui/screens/home/pages/feed_screen.dart';
import 'package:taazakhabar/ui/screens/onboarding/category_selection_screen.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
// import 'package:geolocator/geolocator.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

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
                  hintText: 'Enter your city',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String city = _textController.text;
                  BlocProvider.of<OnboardingBloc>(context).add(CityEnteredEvent(city));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen()));
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
