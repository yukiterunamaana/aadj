import 'package:flutter/material.dart';
import 'package:aadj/globals.dart';

import 'infinite_scroll_pagination_page.dart';

/// Flutter code sample for [BottomNavigationBar].
///
class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    InfiniteScrollPaginationPage(),
    InfiniteScrollPaginationPage(),
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 1: Search',
    //   style: optionStyle,
    // ),
    Text(
      'Index 2: Editor',
      style: optionStyle,
    ),
    InfiniteScrollPaginationPage(),
    InfiniteScrollPaginationPage(),
    // Text(
    //   'Index 3: Notifications',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 4: My account',
    //   style: optionStyle,
    // ),
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
        title: const Text('BottomNavigationBar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
