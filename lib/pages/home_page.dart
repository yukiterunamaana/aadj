import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../globals.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget> {
  final PagingController<int, StatusWidget> pagingController =
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
      final response = await mstdn.v1.timelines.lookupHomeTimeline();
      List responseList = response.data;
      final postList = responseList
          .map((data) => StatusWidget(
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
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, StatusWidget>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<StatusWidget>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => StatusWidget(
                statusId: item.statusId,
              ),
            ),
          ),
        ),
      );
}
