import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart' as mastodon;

import 'date_widget.dart';
import 'notification_type_message.dart';

class NotificationWidget extends StatefulWidget {
  final mastodon.Notification notificationData;

  const NotificationWidget({super.key, required this.notificationData});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  //late Future<mastodon.Notification> _futureNotification;

  //Future<mastodon.Notification>? get notificationData => null;
  //I HATE flutter\packages\flutter\lib\src\widgets\notification_listener.dart
  //I HATE flutter\packages\flutter\lib\src\widgets\notification_listener.dart

  @override
  void initState() {
    super.initState();
    //_futureNotification = notificationData!; //_fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.notificationData.status);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.deepOrangeAccent,
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notificationData.account.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      notificationTextBuilder(widget.notificationData.type),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      convertDate(widget.notificationData.createdAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    widget.notificationData.status != null
                        ? StatusWidget(
                            statusId: widget.notificationData.status!.id)
                        : Container(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
