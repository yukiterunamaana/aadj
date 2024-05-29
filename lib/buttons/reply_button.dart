import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../widgets/post_creator.dart';

class ReplyButton extends StatelessWidget {
  final MastodonApi mastodon;
  final String statusId;

  const ReplyButton(
      {super.key, required this.mastodon, required this.statusId});
  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.reply),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ComposeStatusWidget(
              inReplyToId: statusId,
            );
          },
        );
      },
    );
  }
}
