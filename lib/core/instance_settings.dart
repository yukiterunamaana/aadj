import 'dart:convert';

import 'package:mastodon_api/mastodon_api.dart';

import 'globals.dart';

String instanceSettings = jsonEncode(mstdn.v1.instance.lookupInformation());

List<Emoji> emojis = mstdn.v1.instance.lookupAvailableEmoji() as List<Emoji>;

String settings = mstdn.v1.instance.lookupExtendedDescription() as String;

// int maxCharacters =
//     instanceSettings['configuration']['statuses']['max_characters'] as int;
