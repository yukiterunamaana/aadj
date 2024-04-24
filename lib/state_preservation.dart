import 'package:flutter/material.dart';

import 'globals.dart';

class PreservingBottomNavState extends StatefulWidget {
  const PreservingBottomNavState({Key? key}) : super(key: key);

  @override
  _PreservingBottomNavStateState createState() =>
      _PreservingBottomNavStateState();
}

class _PreservingBottomNavStateState extends State<PreservingBottomNavState> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    //todo home page reel
    Center(
      child: Icon(
        Icons.home,
        size: 150,
      ),
    ),
    //todo search menu
    Center(
      child: Icon(
        Icons.search,
        size: 150,
      ),
    ),
    //todo post constructor
    Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          style: TextStyle(fontSize: 50),
          decoration: InputDecoration(
              labelText: 'Find contact',
              labelStyle: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    ),
    //todo notifications reel
    Center(
      child: Icon(
        Icons.notifications,
        size: 150,
      ),
    ),
    //todo account view
    Center(
      child: Icon(
        Icons.account_circle,
        size: 150,
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preserving State Demo'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: itemColor),
            activeIcon: Icon(
              Icons.home,
              color: selectedItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: itemColor),
            activeIcon: Icon(
              Icons.search,
              color: selectedItemColor,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_square, color: itemColor),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: itemColor),
            activeIcon: Icon(
              Icons.notifications,
              color: selectedItemColor,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: itemColor),
            activeIcon: Icon(
              Icons.account_circle,
              color: selectedItemColor,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
