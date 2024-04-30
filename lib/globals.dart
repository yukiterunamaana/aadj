import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

String instance = 'mastodon.social';

int postsPerRequest = 20;

Color itemColor = Colors.black;
Color? selectedItemColor = Colors.amber[800];

Account? myAcct;
