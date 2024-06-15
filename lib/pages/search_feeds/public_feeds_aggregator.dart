import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

class PublicFeedAggregatorWidget extends StatefulWidget {
  const PublicFeedAggregatorWidget({super.key});

  @override
  PublicFeedAggregatorWidgetState createState() =>
      PublicFeedAggregatorWidgetState();
}

class PublicFeedAggregatorWidgetState extends State<PublicFeedAggregatorWidget>
    with TickerProviderStateMixin {
  final PagingController<int, FeedStatusWidget> pagingController =
      PagingController(firstPageKey: 1);
  static const List<Tab> _tabs = [
    Tab(text: 'This instance'),
    Tab(text: 'Others'),
    Tab(text: 'All'),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final response = await mstdn.v1.timelines.lookupPublicTimeline();
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
          child:
              // PagedListView<int, FeedStatusWidget>(
              //   pagingController: pagingController,
              //   builderDelegate: PagedChildBuilderDelegate<FeedStatusWidget>(
              //     animateTransitions: true,
              //     itemBuilder: (context, item, index) => FeedStatusWidget(
              //       statusId: item.statusId,
              //     ),
              //   ),
              // ),
              Column(
            children: [
              // Search box
              // Tabs
              TabBar(
                controller: _tabController,
                tabs: _tabs,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey[600],
                isScrollable: false,
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    PublicFeedWidget(
                      remote: false,
                      local: true,
                    ),
                    PublicFeedWidget(
                      remote: true,
                      local: false,
                    ),
                    PublicFeedWidget(
                      remote: false,
                      local: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
