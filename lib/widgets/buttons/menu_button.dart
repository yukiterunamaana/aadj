/*
open original
copy link

mention (create reply and add mention)

mute / unmute
block / unblock
report

if post.domain!=domain:
  excommunicate domain
* */
// DropdownButtonHideUnderline(
//
// child: DropdownButton(
//
// value: _selectedOption,
//
// onChanged: (value) {
//
// setState(() {
//
// _selectedOption = value;
//
// });
//
// },
//
// items: [
//
// DropdownMenuItem(
//
// child: Text('Option 1'),
//
// value: 'option1',
//
// ),
//
// DropdownMenuItem(
//
// child: Text('Option 2'),
//
// value: 'option2',
//
// ),
//
// DropdownMenuItem(
//
// child: Text('Option 3'),
//
// value: 'option3',
//
// ),
//
// ],
//
// ),
//
// ),
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../../core/globals.dart';

class MenuButton extends StatefulWidget {
  final MastodonApi mastodon;
  final String statusId;
  final bool? isMuted;
  final bool? isBlocked;

  const MenuButton({
    super.key,
    required this.mastodon,
    required this.statusId,
    required this.isMuted,
    required this.isBlocked,
  });

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  // Create a variable to hold the current state of the menu
  bool _isMenuVisible = false;

  // Create a function to toggle the visibility of the menu
  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Create the button that will summon the menu
        IconButton(
          onPressed: _toggleMenu,
          icon: Icon(Icons.menu),
        ),

        // Create the menu itself
        if (_isMenuVisible)
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Add menu items here
                Text('Menu Item 1'),
                Text('Menu Item 2'),
                Text('Menu Item 3'),
              ],
            ),
          ),
      ],
    );
  }
}
