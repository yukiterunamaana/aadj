import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart' as mastodon;

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
                      widget.notificationData.type.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.notificationData.createdAt.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    widget.notificationData.status != null
                        ? const StatusWidget(statusId: 'notification.status.id')
                        : const SizedBox(height: 0),
                  ],
                ),
              ),
            )

            /*FutureBuilder<mastodon.Notification>(
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
                            ? const StatusWidget(
                                statusId: 'notification.status.id')
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
          ),*/
            ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //     leading: CircleAvatar(
  //       backgroundImage: NetworkImage(notificationData.account.avatar),
  //     ),
  //     title: Text(notification.account.displayName),
  //     subtitle: Text(notification.summary),
  //     trailing: Text(
  //       '${notification.createdAt.difference(DateTime.now()).inMinutes} min ago',
  //       style: TextStyle(color: Colors.grey),
  //     ),
  //   );
  // }
}
