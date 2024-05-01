import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import 'globals.dart';

class MastodonReel extends StatefulWidget {
  final MastodonApi mastodonApi;

  MastodonReel({required this.mastodonApi});

  @override
  _MastodonReelState createState() => _MastodonReelState();
}

class _MastodonReelState extends State<MastodonReel> {
  //late Future<MastodonResponse<List<Status>>> _statusStream;
  // @override
  // void initState() {
  //   super.initState();
  //   _statusStream = mstdn.v1.timelines.lookupHomeTimeline();
  //   print(_statusStream.asStream());
  // }
  late Future<List<Status>> _statusFuture;

  @override
  void initState() {
  super.initState();
  _statusFuture = _getStatuses();
  }

  Future<List<Status>> _getStatuses() async {
  try {
      final response = await mstdn.v1.timelines.lookupHomeTimeline();
      return response.data;
    }
    catch (e) {
      print('Error fetching statuses: $e');
      //rethrow;
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Status>>(
      future: _statusFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final statuses = snapshot.data!;

        return ListView.builder(
          itemCount: statuses.length,
          itemBuilder: (context, index) {
            final status = statuses[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.account.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(status.content),
              ],
            );
          },
        );
      },
    );
  }
}