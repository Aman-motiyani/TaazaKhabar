import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/ui/screens/onboarding/name_input_screen.dart.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      MaterialPageRoute(builder: (context) => BlocProvider(
        create: (context) => OnboardingBloc(),
        child: NameScreen(),
      ));
    });
    return Scaffold(
      body: const Center(
        child: Text("Taaza Khabar"),
      ),
    );
  }
}
