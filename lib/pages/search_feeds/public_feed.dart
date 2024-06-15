import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/globals.dart';
import '../../widgets/post_in_feed_widget.dart';
import '../../core/globals.dart';
import '../../widgets/post_in_feed_widget.dart';

class PublicFeedWidget extends StatefulWidget {
  final bool remote;
  final bool local;
  const PublicFeedWidget(
      {super.key, required this.remote, required this.local});

  @override
  PublicFeedWidgetState createState() => PublicFeedWidgetState();
}

class PublicFeedWidgetState extends State<PublicFeedWidget> {
  final PagingController<int, FeedStatusWidget> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await mstdn.v1.timelines.lookupPublicTimeline(
          onlyLocal: widget.local, onlyRemote: widget.remote);
      List responseList = response.data;
      final postList = responseList
          .map((data) => FeedStatusWidget(
                statusId: data.id,
              ))
          .toList();
      final isLastPage = postList.length < postsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(postList);
        debugPrint('Last page');
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(postList, nextPageKey);
      }
    } catch (error) {
      debugPrint('error! $error');
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, FeedStatusWidget>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<FeedStatusWidget>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => FeedStatusWidget(
                statusId: item.statusId,
              ),
            ),
          ),
        ),
      );
}
