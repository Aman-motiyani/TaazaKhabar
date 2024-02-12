import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/ui/screens/home/nav.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Business',
      'Entertainment',
      'Sports',
      'Technology',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              List<String> selectedCategories = [categories[index]];
              BlocProvider.of<OnboardingBloc>(context).add(CategorySelectedEvent(selectedCategories));
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
            },
          );
        },
      ),
    );
  }
}