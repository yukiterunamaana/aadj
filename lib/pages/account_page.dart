import 'package:aadj/widgets/account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../globals.dart';
import '../widgets/post_view.dart';

class AccountPageWidget extends StatefulWidget {
  final String accountId;
  const AccountPageWidget({super.key, required this.accountId});

  @override
  AccountPageWidgetState createState() => AccountPageWidgetState();
}

class AccountPageWidgetState extends State<AccountPageWidget> {
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
      final response =
          await mstdn.v1.accounts.lookupStatuses(accountId: widget.accountId);
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
          // body: Expanded(
          //   child:
          // Column(children: [
          //   AccountPropertiesWidget(accountId: widget.accountId),
          //   Expanded(
          //     //onRefresh: () => Future.sync(pagingController.refresh),
          //     child: PagedListView<int, StatusWidget>(
          //       pagingController: pagingController,
          //       builderDelegate: PagedChildBuilderDelegate<StatusWidget>(
          //         animateTransitions: true,
          //         itemBuilder: (context, item, index) => StatusWidget(
          //           statusId: item.statusId,
          //         ),
          //       ),
          //     ),
          //   ),
          // ]
          // ),

          body: RefreshIndicator(
        onRefresh: () => Future.sync(pagingController.refresh),
        child: Column(
          children: [
            AccountPropertiesWidget(accountId: widget.accountId),
            PagedListView<int, StatusWidget>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<StatusWidget>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => StatusWidget(
                  statusId: item.statusId,
                ),
              ),
            ),
          ],
        ),
      ));

  //   CustomScrollView(
  //     slivers: [
  //       SliverList(
  //         delegate: SliverChildListDelegate([
  //           AccountPropertiesWidget(accountId: widget.accountId),
  //           PagedListView<int, StatusWidget>(
  //             pagingController: pagingController,
  //             builderDelegate: PagedChildBuilderDelegate<StatusWidget>(
  //               animateTransitions: true,
  //               itemBuilder: (context, item, index) => StatusWidget(
  //                 statusId: item.statusId,
  //               ),
  //             ),
  //           ),
  //         ]),
  //       ),
  //     ],
  //   ),
  // );
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // Header with user info
//           SliverAppBar(
//             pinned: true, // This will keep the header at the top initially
//             floating: true, // This will allow the header to scroll away
//             title: FutureBuilder(
//               future: _accountFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   Account account = snapshot.data! as Account;
//                   return Text(account.displayName);
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//           ),
//           // Feed of posts
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return FutureBuilder(
//                   future: _postsFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       List<Post> posts = snapshot.data!;
//                       return ListTile(
//                         title: Text(posts[index].content),
//                       );
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   },
//                 );
//               },
//               childCount: 10, // Replace with the actual number of posts
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
