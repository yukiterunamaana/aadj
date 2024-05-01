import 'dart:convert';
import 'package:aadj/globals.dart';
import 'package:aadj/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mastodon_api/mastodon_api.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class StatusWidget extends StatefulWidget {
  final String statusId;

  const StatusWidget({super.key, required this.statusId});

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  late Future<Status> _futureStatus;

  @override
  void initState() {
    super.initState();
    _futureStatus = _fetchStatus();
  }

  Future<Status> _fetchStatus() async {
    final mastodon = MastodonApi(
      // Specify mastodon instance like "mastodon.social"
      instance: instance,
      bearerToken: key,
    );

    try {
      final response =
          await mastodon.v1.statuses.lookupStatus(statusId: widget.statusId);
      return response.data;
    } on MastodonException catch (e) {
      // Handle errors here
      print(e.toString());
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Status>(
      future: _futureStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Status status = snapshot.data!;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.account.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status.content,
                    style: const TextStyle(fontSize: 16),
                  ),

                  // Html(
                  //   data: status.content,
                  //   style: {
                  //     "body": Style(
                  //       fontSize: FontSize(16),
                  //     ),
                  //   },
                  // ),

                  // if (status.mediaAttachments.isNotEmpty)
                  //   Column(
                  //     children: status.mediaAttachments
                  //         .map((media) => Padding(
                  //               padding: const EdgeInsets.only(top: 16),
                  //               child: Image.network(
                  //                 media.url,
                  //                 width: double.infinity,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ))
                  //         .toList(),
                  //   ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
