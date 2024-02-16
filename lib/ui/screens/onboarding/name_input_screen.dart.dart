import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:taazakhabar/ui/screens/onboarding/city_selection_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  bool _locationPermissionGranted = false;
  late Position position;
  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    setState(() {
      _locationPermissionGranted = permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    });
    if(_locationPermissionGranted){
      getLocation();
    }
  }

  Future<Position> getLocation()async{
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final ColorScheme col = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: col.primaryContainer,
        title:  Text("Enter Name" , style: TextStyle(color: col.primary)),
      ),
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is NameUpdated) {
            // Print a message when the name is updated/saved successfully
            print('Name saved successfully: ${state.name}');
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _locationPermissionGranted ? () async {
                    if (position != null) {
                      String name = _textController.text;
                      context.read<OnboardingBloc>().add(NameChanged(name));
                      // Navigate to the CityScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen(position: position,)),
                      );
                    } else {
                      // Handle situation when position is null
                      print('Failed to retrieve location.');
                    }
                  } : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
