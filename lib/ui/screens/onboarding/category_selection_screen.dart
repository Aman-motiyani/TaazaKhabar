import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../home/nav.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  late List<String> selectedCategories = [];
  final List<String> categories = [
    'Business',
    'Entertainment',
    'Sports',
    'Technology',
  ];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          selectedCategories = List.from(state.selectedCategories);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Select Categories'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildCategoryList(),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30 , right: 10),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<OnboardingBloc>(context).saveToSharedPreferences();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(),
                  ),
                );
              },
              child: Icon(Icons.check),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategories.contains(category);
        return CheckboxListTile(
          title: Text(category),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedCategories.add(category);
              } else {
                selectedCategories.remove(category);
              }
            });
            // Update the selected categories in the bloc
            BlocProvider.of<OnboardingBloc>(context)
                .add(CategorySelected(category));
          }
        );
      },
    );
  }

}
