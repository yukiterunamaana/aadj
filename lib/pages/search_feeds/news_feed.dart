import 'package:aadj/core/key.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/globals.dart';
import '../../widgets/post_in_feed_widget.dart';

class NewsFeedWidget extends StatefulWidget {
  const NewsFeedWidget({super.key});

  @override
  NewsFeedWidgetState createState() => NewsFeedWidgetState();
}

class NewsFeedWidgetState extends State<NewsFeedWidget> {
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
    //try
    {
      // Define the URL for the request
      final url = Uri.parse(
          'https://$instance/api/v1/trends/links'); // Replace with your instance URL
      // Perform the GET request
      final response = await http.get(url, headers: {
        'Authorization':
            'Bearer $mastodonUserToken', // Replace with your access token
      });
      print(response);
      //   List responseList = response.;
      //   final postList = responseList
      //       .map((data) => FeedStatusWidget(
      //             statusId: data.id,
      //           ))
      //       .toList();
      //   final isLastPage = postList.length < postsPerRequest;
      //   if (isLastPage) {
      //     pagingController.appendLastPage(postList);
      //     debugPrint('Last page');
      //   } else {
      //     final nextPageKey = pageKey + 1;
      //     pagingController.appendPage(postList, nextPageKey);
      //   }
      // } catch (error) {
      //   debugPrint('error! $error');
      //   pagingController.error = error;
      // }
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
