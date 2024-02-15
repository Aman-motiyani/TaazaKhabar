import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taazakhabar/ui/screens/home/pages/fav_screen.dart';

import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../blocs/onboarding_bloc/onboarding_controller.dart';

class Settings extends StatefulWidget {
  final OnboardingBloc onboardingBloc;

  const Settings({
    Key? key,
    required this.onboardingBloc,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  OnboardingController controller = Get.put(OnboardingController());
  List<String> allCategories = [
    'Business',
    'Entertainment',
    'Sports',
    'Technology',
  ];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  late List<String> selectedCategories;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cityController = TextEditingController();
    selectedCategories = [];
    // Fetch initial data from the bloc
    widget.onboardingBloc.add(FetchInitialData());
    _updateStateFromBloc(widget.onboardingBloc.state);
  }

  void _updateStateFromBloc(OnboardingState state) {
    print(state);
    if (state is NameUpdated) {
      setState(() {
        _nameController.text = state.name;
      });
    } else if (state is CategoriesUpdated) {
      setState(() {
        selectedCategories = List.from(state.selectedCategories);
      });
    } else if (state is CityNameUpdated) {
      setState(() {
        _cityController.text = state.cityName;
      });
    } else if (state is DataLoaded) {
      setState(() {
        _nameController.text = state.name;
        _cityController.text = state.cityName;
        selectedCategories = List.from(state.selectedCategories);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'Favorite Categories:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildCategoryList(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allCategories.length,
      itemBuilder: (context, index) {
        final category = allCategories[index];
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
          }
              : null,
        );
      },
    );
  }

  void _saveChanges() {
    widget.onboardingBloc.add(CityNameChanged(_cityController.text));
    widget.onboardingBloc.add(NameChanged(_nameController.text));
    for (String category in selectedCategories) {
      widget.onboardingBloc.add(CategorySelected(category));
    }
  }
}