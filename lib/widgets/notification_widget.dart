import 'package:aadj/globals.dart';
import 'package:aadj/widgets/post_bottom_bar.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mastodon_api/mastodon_api.dart' as mastodon;

class NotificationWidget extends StatefulWidget {
  final String notificationId;

  const NotificationWidget({super.key, required this.notificationId});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late Future<mastodon.Notification> _futureNotification;
  //I HATE flutter\packages\flutter\lib\src\widgets\notification_listener.dart
  //I HATE flutter\packages\flutter\lib\src\widgets\notification_listener.dart

  @override
  void initState() {
    super.initState();
    _futureNotification = _fetchNotification();
  }

  Future<mastodon.Notification> _fetchNotification() async {
    try {
      final response = await mstdn.v1.notifications
          .lookupNotification(notificationId: widget.notificationId);
      return response.data;
    } on mastodon.MastodonException catch (e) {
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
          //color: //bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<mastodon.Notification>(
            future: _futureNotification,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                mastodon.Notification notification = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.account.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          notification.type as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          notification.createdAt as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        notification.status != null
                            ? StatusWidget(statusId: 'notification.status.id')
                            : const SizedBox(height: 0),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
