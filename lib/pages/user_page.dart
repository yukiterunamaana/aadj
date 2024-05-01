import 'dart:async';
import 'package:mastodon_api/mastodon_api.dart';
import 'package:flutter/material.dart';

import '../post.dart';

class AccountStream extends StatefulWidget {
  final MastodonApi mastodon;
  final String accountId;

  AccountStream({
    required this.mastodon,
    required this.accountId,
  });

  @override
  _AccountStreamState createState() => _AccountStreamState();

  Future<void> reblogBuilder(BuildContext context, reblog) async {}

  Future<void> postBuilder(BuildContext context, status) async {}
}

class _AccountStreamState extends State<AccountStream> {
  late StreamController<List<dynamic>> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<dynamic>>.broadcast();
    _loadMore();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> _loadMore() async {
    try {
      final account = await widget.mastodon.v1.accounts
          .lookupAccount(accountId: widget.accountId);
      final statusesResponse = await widget.mastodon.v1.accounts.lookupStatuses(
        accountId: widget.accountId,
        excludeReblogs: false,
      );
      final statuses = statusesResponse.data; // Access the value property
      final posts = statuses.toList();
      _streamController.sink.add([account, posts]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final account = snapshot.data?[0];
            final posts = snapshot.data?[1];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.displayName,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        account.username,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        account.note,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return posts[index];
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
