import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  List<String> allCategories = ['a', 'b', 'c', 'd'];
  List<String> selectedCategories = ['a', 'c'];

  @override
  void initState() {
    super.initState();
    _nameController.text = "Aman";
    _cityController.text = "Jaipur";
  }

  bool _isEditing = false;

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
                  // Save changes here
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
}
