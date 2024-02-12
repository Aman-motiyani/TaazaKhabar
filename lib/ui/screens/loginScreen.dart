import 'package:flutter/material.dart';
import 'package:taazakhabar/ui/screens/onboarding/onboarding.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    return Scaffold(
      body: const Center(
        child: Text("Taaza Khabar"),
      ),
    );
  }
}