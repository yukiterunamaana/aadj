import 'dart:convert';

import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../globals.dart';

class MastodonPostView extends StatefulWidget {
  final String statusId;

  MastodonPostView({super.key, required this.statusId});

  @override
  _MastodonPostViewState createState() => _MastodonPostViewState();
}

class _MastodonPostViewState extends State<MastodonPostView> {
  //late Future<StatusContext> context;

  @override
  void initState() {
    super.initState();
    _loadAncestorsAndReplies();
  }

  void _loadAncestorsAndReplies() async {
    try {
      final response = await mstdn.v1.statuses
          .lookupStatusContext(statusId: widget.statusId);
      List<String> ancestors = [];
      List<String> descendants = [];

      for (Status s in response.data.ancestors) {
        ancestors.add(s.id);
      }
      for (Status s in response.data.descendants) {
        descendants.add(s.id);
      }
      print('Ancestors: $ancestors');
      print('Descendants: $descendants');
    } on MastodonException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mastodon Post'),
      ),
      body: ListView(
        children: [
          // Display the post
          StatusWidget(
            key: widget.key,
            statusId: widget.statusId,
          ),
          //
          // // Display the ancestors
          // _ancestors.isEmpty
          //     ? Container()
          //     : Column(
          //         children: [
          //           Text('Ancestors:'),
          //           ..._ancestors.map((ancestor) => PostCard(post: ancestor)),
          //         ],
          //       ),
          //
          // // Display the replies
          // _replies.isEmpty
          //     ? Container()
          //     : Column(
          //         children: [
          //           Text('Replies:'),
          //           ..._replies.map((reply) => PostCard(post: reply)),
          //         ],
          //       ),
        ],
      ),
    );
  }
}
