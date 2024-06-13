import 'package:aadj/core/globals.dart';
import 'package:aadj/pages/query_page.dart';
import 'package:aadj/pages/search_feeds/news_feed.dart';
import 'package:aadj/pages/search_feeds/public_feed.dart';
import 'package:flutter/material.dart';

class SearchWithTabs extends StatefulWidget {
  const SearchWithTabs({super.key});

  @override
  _SearchWithTabsState createState() => _SearchWithTabsState();
}

class _SearchWithTabsState extends State<SearchWithTabs>
    with TickerProviderStateMixin {
  static const List<Tab> _tabs = [
    Tab(text: 'Public'),
    Tab(text: 'Hashtags'),
    Tab(text: 'People'),
    Tab(text: 'News'),
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _queryController = TextEditingController();
    return Column(
      children: [
        // Search box
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 48,
          child:

              /*
                  TextFormField(
          controller: _statusController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a query first';
            }
            return null;
          },
          onSubmitted: (text) async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QueryPageWidget(
                      query: text,
                    ),
                  ),
                );
              },
        ),
          * */
              TextField(
                  controller: _queryController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(8),
                  ),
                  onSubmitted: (text) async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QueryPageWidget(
                          query: text,
                        ),
                      ),
                    );
                  }),
        ),
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
            children: [
              // todo Replace these with the actual content for each tab
              PublicFeedWidget(),
              Center(child: Text('Hashtags')),
              Center(child: Text('People')),
              NewsFeedWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
