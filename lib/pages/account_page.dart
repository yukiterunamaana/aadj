import 'package:aadj/widgets/account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mastodon_api/mastodon_api.dart';
import '../globals.dart';
import '../widgets/post_in_feed_widget.dart';
import '../widgets/post_view.dart';

class AccountPageWidget extends StatefulWidget {
  final String accountId;
  const AccountPageWidget({super.key, required this.accountId});

  @override
  AccountPageWidgetState createState() => AccountPageWidgetState();
}

class AccountPageWidgetState extends State<AccountPageWidget> {
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
      final response =
          await mstdn.v1.accounts.lookupStatuses(accountId: widget.accountId);
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
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(pagingController.refresh),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const AccountPropertiesWidget(
                      accountId: myAccount,
                    ),
                    // background: Image.network(
                    // _mastodonApi.currentUser.header,
                    // fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ];
            },
            body: PagedListView<int, FeedStatusWidget>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<FeedStatusWidget>(
                itemBuilder: (context, item, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          child:
                              item //StatusWidget(statusId: widget.accountId),
                          ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
}
//     PagedListView<int, StatusWidget>(
//   pagingController: pagingController,
//   builderDelegate: PagedChildBuilderDelegate<StatusWidget>(
//     itemBuilder: (context, item, index) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           index == 0
//               ? AccountPropertiesWidget(accountId: widget.accountId)
//               : Container(
//                   child: StatusWidget(statusId: widget.accountId)),
//           if (index < pagingController.itemList!.length - 1) Divider(),
//         ],
//       );
//     },
//   ),
// ),
//  ));
