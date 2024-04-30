import 'dart:async';
import 'package:mastodon_api/mastodon_api.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

typedef StatusBuilder = Widget Function(BuildContext context, Status status);

class StatusStream extends StatefulWidget {
  final MastodonApi mastodon;
  final String sinceId;
  final StatusBuilder builder;

  StatusStream({
    required this.mastodon,
    required this.sinceId,
    required this.builder,
    required String accountId,
  });

  @override
  _StatusStreamState createState() => _StatusStreamState();
}

class _StatusStreamState extends State<StatusStream> {
  late StreamController<List<Status>> _statusController;

  @override
  void initState() {
    super.initState();
    _statusController = StreamController<List<Status>>.broadcast();
    _loadMore();
  }

  @override
  void dispose() {
    _statusController.close();
    super.dispose();
  }

  Future<void> _loadMore() async {
    try {
      final statuses = await widget.mastodon.v1.timelines.lookupHomeTimeline(
        limit: postsPerRequest,
      );
      _statusController.sink.add(statuses as List<Status>);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Status>>(
      stream: _statusController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final statuses = snapshot.data;
          return ListView.builder(
            itemCount: statuses?.length,
            itemBuilder: (context, index) {
              return widget.builder(context, statuses![index]);
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
