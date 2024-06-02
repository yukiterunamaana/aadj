import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../core/globals.dart';
import '../widgets/notification_widget.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  NotificationPageWidgetState createState() => NotificationPageWidgetState();
}

class NotificationPageWidgetState extends State<NotificationPageWidget> {
  final PagingController<int, NotificationWidget> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    //fetchNotifications();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await mstdn.v1.notifications.lookupNotifications();
      List responseList = response.data;
      print(responseList.map);
      final notifList = responseList
          .map((data) => NotificationWidget(
                notificationData: data,
              ))
          .toList();
      final isLastPage = notifList.length < postsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(notifList);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(notifList, nextPageKey);
      }
    } catch (error) {
      debugPrint('error! $error');
      pagingController.error = error;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('trending'),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, NotificationWidget>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<NotificationWidget>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => NotificationWidget(
                      notificationData: item.notificationData,
                    )),
          ),
        ),
      );
}
