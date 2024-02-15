import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/ui/screens/home/nav.dart';

class CategoryScreen extends StatefulWidget {
  final OnboardingBloc onboardingBloc; // Accept the OnboardingBloc instance as a parameter
  const CategoryScreen({Key? key, required this.onboardingBloc}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> selectedCategories = []; // List to store selected categories

  // List of categories
  final List<String> categories = [
    'Business',
    'Entertainment',
    'Sports',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category),
            // Check if the category is already selected
            selected: selectedCategories.contains(category),
            onTap: () {
              setState(() {
                // If category is already selected, remove it, else add it
                if (selectedCategories.contains(category)) {
                  selectedCategories.remove(category);
                } else {
                  selectedCategories.add(category);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add the list of selected categories to the bloc
         for (String category in categories){
           widget.onboardingBloc.add(CategorySelected(category));
         }
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
