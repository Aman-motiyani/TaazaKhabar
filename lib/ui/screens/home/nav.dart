import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_bloc.dart';
import 'package:taazakhabar/blocs/news_bloc/news_event.dart';
import 'package:taazakhabar/ui/screens/home/pages/fav_screen.dart';
import 'package:taazakhabar/ui/screens/home/pages/feed_screen.dart';
import 'package:taazakhabar/ui/screens/home/pages/saved_screen.dart';
import 'package:taazakhabar/ui/screens/home/settings.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _BottomNavState();
}

class _BottomNavState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
  }
  // Define a list of tab titles
  final List<String> tabTitles = [
    'Feed',
    'Fav',
    'Saved',
  ];

  // Define a map to associate tab titles with widgets
  final Map<String, Widget> pages = {
    'Feed': FeedScreen(),
    'Fav': FavScreen(),
    'Saved': SavedScreen(),
  };

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taaza Khabar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Settings(),));
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: pages[tabTitles[_selectedIndex]],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fav',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
