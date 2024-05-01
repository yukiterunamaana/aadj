import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class ReplyButton extends StatelessWidget {
  final MastodonApi mastodon;
  final String statusId;

  ReplyButton({super.key, required this.mastodon, required this.statusId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return IconButton(
  //     icon: Icon(Icons.reply),
  //     onPressed: () {
  //       showModalBottomSheet(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return null;
  //           // return NewPostWidget(
  //           //   mastodon: mastodon,
  //           //   inReplyToId: statusId,
  //           // );
  //         },
  //       );
  //     },
  //   );
  // }
}
