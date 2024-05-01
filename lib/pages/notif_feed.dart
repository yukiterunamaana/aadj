import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class NotificationsFeed extends StatefulWidget {
  final MastodonApi mastodon;

  NotificationsFeed({required this.mastodon});

  @override
  _NotificationsFeedState createState() => _NotificationsFeedState();
}

class _NotificationsFeedState extends State<NotificationsFeed> {
  String _sinceId;

  @override
  Widget build(BuildContext context) {
    return NotificationStream(
      mastodon: widget.mastodon,
      sinceId: _sinceId,
      builder: (context, notification) {
        return Notification(
          mastodon: widget.mastodon,
          notification: notification,
          onMarkRead: () {
            setState(() {
              _sinceId = notification.id;
            });
          },
        );
      },
    );
  }
}
