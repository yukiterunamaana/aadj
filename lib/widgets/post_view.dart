import 'package:aadj/core/globals.dart';
import 'package:aadj/widgets/post_bottom_bar.dart';
import 'package:aadj/widgets/post_thread_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mastodon_api/mastodon_api.dart';

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
            Padding(
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

                            Text(
                              status.account.displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Text(
                            //   status.content,
                            //   style: const TextStyle(fontSize: 16),
                            // ),
                            HtmlWidget(status.content),
                            Expanded(
                              child: Column(
                                children: status.mediaAttachments
                                    .map((media) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Image.network(
                                            media.previewUrl,
                                            //width: double.infinity,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            //AnyLinkPreview(link: '',) todo link preview
                            PostBottomBar(
                                statusId: widget.statusId,
                                isReblogged: status.isReblogged,
                                isFavourited: status.isFavourited,
                                isBookmarked: status.isBookmarked),
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
          ],
        ),
      ),
    );
  }
}
