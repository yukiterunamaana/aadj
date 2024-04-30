import 'dart:async';
import 'package:mastodon_api/mastodon_api.dart';
import 'package:flutter/material.dart';

typedef NotificationBuilder = Widget Function(
    BuildContext context, Notification notification);

class NotificationStream extends StatefulWidget {
  final MastodonApi mastodon;
  final String sinceId;
  final NotificationBuilder builder;

  NotificationStream({
    @required this.mastodon,
    this.sinceId,
    @required this.builder,
  });

  @override
  _NotificationStreamState createState() => _NotificationStreamState();
}

class _NotificationStreamState extends State<NotificationStream> {
  StreamController<List<Notification>> _notificationController;

  @override
  void initState() {
    super.initState();
    _notificationController = StreamController<List<Notification>>.broadcast();
    _loadMore();
  }

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }

  Future<void> _loadMore() async {
    try {
      final notifications = await widget.mastodon.v1.notifications.get(
        maxId: widget.sinceId,
      );
      _notificationController.sink.add(notifications);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Notification>>(
      stream: _notificationController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final notifications = snapshot.data;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return widget.builder(context, notifications[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
