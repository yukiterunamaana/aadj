import 'package:aadj/widgets/account_view.dart';
import 'package:aadj/widgets/post_creator.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import '../pages/account_page.dart';
import '../pages/home_page.dart';
import '../pages/notification_page.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePageWidget(),

    //todo search menu
    Center(
      child: Icon(
        Icons.search,
        size: 150,
      ),
    ),

    //todo post constructor
    Center(
      child: ComposeStatusWidget(),
      //     Icon(
      //   Icons.newspaper,
      //   size: 150,
      // ),
    ),

    //todo notifications reel
    Center(
      child: NotificationPageWidget(),
      // Icon(
      //   Icons.notifications,
      //   size: 150,
      // ),
    ),

    //todo account view
    const AccountPageWidget(accountId: myAccount),
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
        title: const Text('Aadj'),
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
