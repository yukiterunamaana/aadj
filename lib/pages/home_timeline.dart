import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';
import '../widgets/post_view.dart';
import 'home_page.dart';

class HomeTimeline extends StatefulWidget {
  final MastodonApi mastodon;

  HomeTimeline({required this.mastodon});

  @override
  _HomeTimelineState createState() => _HomeTimelineState();
}

class _HomeTimelineState extends State<HomeTimeline> {
  late String _sinceId;

  @override
  Widget build(BuildContext context) {
    return StatusStream(
      mastodon: widget.mastodon,
      sinceId: _sinceId,
      builder: (context, status) {
        return StatusWidget(
          statusId: '',
          // mastodon: widget.mastodon,
          // status: status,
          // onReblog: () {
          //   setState(() {
          //     _sinceId = status.id;
          //   });
          // },
        );
      },
    );
  }
}
