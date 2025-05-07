import 'package:egg_project/homepage/homepage.dart';
import 'package:egg_project/profile/profile.dart';
import 'package:flutter/material.dart';

class Mainhome extends StatefulWidget {
  const Mainhome({super.key});

  @override
  State<Mainhome> createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  int _selectedIndex = 0;

  // Placeholder widgets for each page
  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 30,
          backgroundColor: Colors.white,
          title: const Text(
            'Farms',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 29,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.grey,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }
}
