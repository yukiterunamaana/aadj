import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../core/globals.dart';
import '../widgets/post_in_feed_widget.dart';

class QueryPageWidget extends StatefulWidget {
  final String query;
  const QueryPageWidget({super.key, required this.query});

  @override
  QueryPageWidgetState createState() => QueryPageWidgetState();
}

class QueryPageWidgetState extends State<QueryPageWidget> {
  final PagingController<int, FeedStatusWidget> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await mstdn.v2.search.searchContents(
          query: widget.query, type: SearchContentType.statuses);
      print(response.data);
      List responseList = response.data.statuses as List;
      print(responseList);
      final postList = responseList
          .map((data) => FeedStatusWidget(
                statusId: data.id,
              ))
          .toList();
      print(postList);
      final isLastPage = postList.length < postsPerRequest;
      if (isLastPage) {
        pagingController.appendLastPage(postList);
        debugPrint('Last page');
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(postList, nextPageKey);
      }
    } catch (error) {
      debugPrint(
          'error!!! $error'); //TODO figure out why the `sco` of all things holy... is it someone's standard of language notation?
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
          title: Text('Results for ${widget.query}'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
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
