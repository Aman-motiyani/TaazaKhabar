import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';// Import the geocoding package
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taazakhabar/modules/onboarding/presentation/logic/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/modules/onboarding/presentation/ui/category_selection_screen.dart';


class CityScreen extends StatefulWidget {
  final Position position;

  const CityScreen({Key? key, required this.position})
      : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _textController = TextEditingController();
  String? city;

  @override
  void initState() {
    super.initState();
    _getCityNameFromCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme col = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: col.primaryContainer,
        title: Text(
          "Select City",
          style: TextStyle(color: col.primary),
        ),
        leading: IconButton(
          color: col.primary,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                  onChanged: (value) {
                    city = value;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (city != null) {
                      context.read<OnboardingBloc>().add(CityNameChanged(city!)); // Use the passed OnboardingBloc instance
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(),
                        ),
                      );
                    }
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      );
  }

  // Method to get the city name from coordinates
  Future<void> _getCityNameFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.position.latitude,
        widget.position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String cityName = placemark.locality ?? ''; // Use locality for city name
        setState(() {
          _textController.text = cityName; // Set the city name in the text field
          city = cityName; // Set the city name in the state variable
        });
      }
    } catch (e) {
      print('Error getting city name: $e');
    }
  }
}
