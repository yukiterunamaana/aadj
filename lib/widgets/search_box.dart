// import 'package:flutter/material.dart';
// import 'package:mastodon_api/mastodon_api.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//
// class SearchBox extends StatefulWidget {
//   @override
//   _SearchBoxState createState() => _SearchBoxState();
// }
//
// class _SearchBoxState extends State<SearchBox> {
//   final _formKey = GlobalKey<FormState>();
//   final _queryController = TextEditingController();
//   MastodonApi _mastodonApi;
//   PagingController<int, SearchResult> _pagingController;
//
//   @override
//   void initState() {
//     super.initState();
//     _mastodonApi = MastodonApi(
//       // Your instance URL
//       instanceUrl: 'https://mastodon.example.com',
//       // Your access token
//       accessToken: 'your_access_token',
//     );
//     _pagingController = PagingController(firstPageKey: 1);
//   }
//
//   Future<void> _searchContents() async {
//     if (_formKey.currentState.validate()) {
//       final query = _queryController.text;
//       _pagingController.refresh();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SearchResultsPage(
//             query: query,
//             pagingController: _pagingController,
//           ),
//         ),
//       );
//     }
//   }
//
//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       final response = await _mastodonApi.v2.search.searchContents(
//         query: _queryController.text,
//         page: pageKey,
//       );
//       final results = response.result;
//       final isLastPage = results.length <
//           20; // adjust this value based on your API's pagination
//       if (isLastPage) {
//         _pagingController.appendLastPage(results);
//       } else {
//         final nextPageKey = pageKey + 1;
//         _pagingController.appendPage(results, nextPageKey);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }
// }
//
// class SearchResultsPage extends StatefulWidget {
//   final String query;
//   final PagingController<int, SearchResult> pagingController;
//
//   SearchResultsPage({
//     required this.query,
//     required this.pagingController,
//   });
//
//   @override
//   _SearchResultsPageState createState() => _SearchResultsPageState();
// }
//
// class _SearchResultsPageState extends State<SearchResultsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Results'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: PagedListView<int, SearchResult>(
//         pagingController: widget.pagingController,
//         builderDelegate: PagedChildBuilderDelegate<SearchResult>(
//           animateTransitions: true,
//           itemBuilder: (context, item, index) {
//             return ListTile(
//               title: Text(item.account.username),
//               subtitle: Text(item.status.content),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
