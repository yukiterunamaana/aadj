// import 'package:flutter/material.dart';
//
// class SearchWithTabs extends StatefulWidget {
//   const SearchWithTabs({super.key});
//
//   @override
//   _SearchWithTabsState createState() => _SearchWithTabsState();
// }
//
// class _SearchWithTabsState extends State<SearchWithTabs>
//     with TickerProviderStateMixin {
//   static const List<Tab> _tabs = [
//     Tab(text: 'Public'),
//     Tab(text: 'Hashtags'),
//     Tab(text: 'People'),
//     Tab(text: 'News'),
//   ];
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _tabs.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Search box
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           height: 48,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//               contentPadding: EdgeInsets.all(8),
//             ),
//           ),
//         ),
//         // Tabs
//         TabBar(
//           controller: _tabController,
//           tabs: _tabs,
//           indicatorColor: Colors.blue,
//           labelColor: Colors.blue,
//           unselectedLabelColor: Colors.grey[600],
//           isScrollable: false,
//         ),
//         // TabBarView
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               // Replace these with the actual content for each tab
//               Center(child: Text('Public')),
//               Center(child: Text('Hashtags')),
//               Center(child: Text('People')),
//               Center(child: Text('News')),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchWithTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cards'),
        ),
        body: PagedListView<int, Map<String, dynamic>>(
          pagingController: _postsPagingController,
          builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
            itemBuilder: (context, item, index) => _PostCard(
              title: item['title'],
              imageUrl: item['image_url'],
              content: item['content'],
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text('No posts found.'),
            ),
          ),
        ),
      ),
    );
  }

  final _postsPagingController =
      PagingController<int, Map<String, dynamic>>(firstPageKey: 0);

  @override
  void initState() {
    _postsPagingController.addPageRequestListener((pageKey) {
      _fetchPosts(pageKey);
    });
  }

  Future<void> _fetchPosts(int pageKey) async {
    try {
      // Fetch data from an API
      // For simplicity, I'm using a static JSON string
      final response = '''
      [
        {
          "title": "Title 1",
          "image_url": "https://example.com/image1.jpg",
          "content": "This is the content of post 1."
        },
        {
          "title": "Title 2",
          "image_url": "https://example.com/image2.jpg",
          "content": "This is the content of post 2."
        }
      ]
      ''';
      final posts = jsonDecode(response) as List<Map<String, dynamic>>;

      // Check if there are more posts to fetch
      final isLastPage = posts.length < 10; // Replace 10 with your page size
      if (isLastPage) {
        _postsPagingController.appendLastPage(posts);
      } else {
        final newPageKey = pageKey + posts.length;
        _postsPagingController.appendPage(posts, newPageKey);
      }
    } catch (error) {
      _postsPagingController.error = error;
    }
  }
}

class _PostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;

  _PostCard(
      {required this.title, required this.imageUrl, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
          ),
          // Content
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                // Content
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
