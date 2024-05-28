import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';
import 'instance_settings.dart';
import 'key.dart';

Color itemColor = Colors.black;
Color? blobColor1 = Colors.amber;
Color? blobColor2 = Colors.amber;
Color? activatedReactionColor = Colors.red;
Color bgColor = Colors.amber;

bool animationsEnabled = false;

int postsPerRequest = 20; //max 40, default 20
const String myAccount = '112282440600157454';
MastodonApi mstdn =
    MastodonApi(instance: instance, bearerToken: mastodonUserToken);
Application app = const Application(name: 'Aadj', vapidKey: '');
//todo ask about vapid key

const TextStyle headerStyle = TextStyle(fontSize: 16);
const TextStyle tagStyle = TextStyle(fontSize: 16);
const TextStyle contentStyle = TextStyle(fontSize: 16);
