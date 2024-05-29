import 'package:aadj/globals.dart';
import 'package:aadj/widgets/post_bottom_bar.dart';
import 'package:aadj/widgets/post_thread_view.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mastodon_api/mastodon_api.dart';

class FeedStatusWidget extends StatefulWidget {
  final String statusId;

  const FeedStatusWidget({super.key, required this.statusId});

  @override
  _FeedStatusWidgetState createState() => _FeedStatusWidgetState();
}

class _FeedStatusWidgetState extends State<FeedStatusWidget> {
  late Future<Status> _futureStatus;
  @override
  void initState() {
    super.initState();
    _futureStatus = _fetchStatus();
  }

  Future<Status> _fetchStatus() async {
    try {
      final response =
          await mstdn.v1.statuses.lookupStatus(statusId: widget.statusId);
      //print(response.data.toString());
      return response.data;
    } on MastodonException catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.amber,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StatusContextWidget(statusId: widget.statusId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder<Status>(
                  future: _futureStatus,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Status status = snapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // status.isReblogged != null
                              //     ? Row(
                              //         children: [
                              //           Icon(Icons.repeat_on),
                              //           Text(status.isReblogged.toString())
                              //         ],
                              //       )
                              //     : const SizedBox(height: 0),
                              // status.inReplyToAccountId != null
                              //     ? Row(
                              //         children: [
                              //           Icon(Icons.reply),
                              //           Text(status.inReplyToAccountId
                              //               .toString())
                              //         ],
                              //       )
                              //     : const SizedBox(height: 0),

                              StatusWidget(statusId: widget.statusId),
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
