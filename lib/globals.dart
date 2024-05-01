import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import 'key.dart';

String instance = 'mastodon.social';

Color itemColor = Colors.black;
Color? selectedItemColor = Colors.amber;
Color? activatedReactionColor = Colors.red;

int postsPerRequest = 20;
String myAccount = '112282440600157454';
MastodonApi mstdn = MastodonApi(instance: instance, bearerToken: key);
