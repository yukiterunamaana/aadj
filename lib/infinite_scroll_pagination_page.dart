import 'dart:convert';

import 'package:aadj/post.dart';
import 'package:aadj/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'globals.dart';

class InfiniteScrollPaginationPage extends StatefulWidget {
  const InfiniteScrollPaginationPage({super.key});

  @override
  InfiniteScrollPaginationPageState createState() =>
      InfiniteScrollPaginationPageState();
}

class InfiniteScrollPaginationPageState
    extends State<InfiniteScrollPaginationPage> {
  final PagingController<int, Post> pagingController =
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
      final response = await get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$postsPerRequest'));
      List responseList = json.decode(response.body);
      final postList = responseList
          .map((data) => Post(
                id: data['id'],
                title: data['title'],
                body: data['body'],
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
        appBar: AppBar(
          title: const Text('trending'),
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: PagedListView<int, Post>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
              animateTransitions: true,
              itemBuilder: (context, item, index) =>
                  PostWidget(id: item.id, title: item.title, body: item.body),
            ),
          ),
        ),
      );
}
