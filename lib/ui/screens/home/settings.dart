import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  late List<String> selectedCategories = [];
  final List<String> categories = [
    'Business',
    'Entertainment',
    'Sports',
    'Technology',
  ];

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          print(state.name);
          _nameController.text = state.name;
          _cityController.text = state.cityName;
          selectedCategories = List.from(state.selectedCategories);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            actions: [
              IconButton(
                icon: Icon(_isEditing ? Icons.done : Icons.edit),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                    if (!_isEditing) {
                      _saveChanges();
                    }
                  });
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _nameController,
                  readOnly: !_isEditing,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'City:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _cityController,
                  readOnly: !_isEditing,
                  decoration: InputDecoration(
                    hintText: 'Enter your city',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Favorite Categories:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildCategoryList(),
              ],
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
          onChanged: _isEditing
              ? (value) {
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
              : null,
        );
      },
    );
  }

  void _saveChanges() {
    final String newName = _nameController.text;
    final String newCity = _cityController.text;

    // Dispatch an event to update the name and city in the bloc
    BlocProvider.of<OnboardingBloc>(context).add(CityNameChanged(newCity));
    BlocProvider.of<OnboardingBloc>(context).add(NameChanged(newName));
    BlocProvider.of<OnboardingBloc>(context).saveToSharedPreferences(Uname: newName);
  }
}
