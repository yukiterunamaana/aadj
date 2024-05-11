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
  late Future<StatusContext> context;

  @override
  void initState() {
    super.initState();
    context = _loadAncestorsAndReplies();
  }

  Future<StatusContext> _loadAncestorsAndReplies() async {
    try {
      final response =
          await mstdn.v1.statuses.lookupStatusContext(statusId: widget.statusId);
      return response.data;
    } on MastodonException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    final _ancestors = ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mastodon Post'),
      ),
      body: ListView(
        children: [
          // Display the post
          StatusWidget(key: widget.key, statusId: widget.statusId,),

          // Display the ancestors
          _ancestors.isEmpty
              ? Container()
              : Column(
                  children: [
                    Text('Ancestors:'),
                    ..._ancestors.map((ancestor) => PostCard(post: ancestor)),
                  ],
                ),

          // Display the replies
          _replies.isEmpty
              ? Container()
              : Column(
                  children: [
                    Text('Replies:'),
                    ..._replies.map((reply) => PostCard(post: reply)),
                  ],
                ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.account.username),
            Text(post.content),
          ],
        ),
      ),
    );
  }
}
