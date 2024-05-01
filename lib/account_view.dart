import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';
import '../globals.dart';

class AccountWidget extends StatefulWidget {
  final String accountId;

  const AccountWidget({super.key, required this.accountId});

  @override
  _AccountWidgetState createState() =>
      _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late Future<Account> _futureAccount;

  @override
  void initState() {
    super.initState();
    _futureAccount = _fetchAccount();
  }

  Future<Account> _fetchAccount() async {
    try {
      final response =
        await mstdn.v1.accounts.lookupAccount(accountId: widget.accountId);
      print(response.data.toString());
      return response.data;
    } on MastodonException catch (e) {
      // Handle errors here
      print(e.toString());
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Account>(
      future: _futureAccount,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Account account = snapshot.data!;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   'ID: ${account.id}',
                  // ),
                  Text(
                    'Username: ${account.username}',
                  ),
                  Text(
                    'Display Name: ${account.displayName}',
                  ),
                  Text(
                    'Display Name: ${account.acct}',
                  ),
                  Text(
                    'Description: ${account.note}',
                  ),

                  Expanded(child:
                    Image.network(
                      account.avatar,
                    ),
                  ),

                  Expanded(child:
                    Image.network(
                      account.header,
                    ),
                  ),

                  Text(
                    '${account.statusesCount} posts, ${account.followingCount} follows, ${account.followersCount} followers',
                  ),
                  // Text(
                  //   'subscribingCount: ${account.subscribingCount ?? 0}',
                  // ),
                  Text(
                    'isLocked: ${account.isLocked}',
                  ),
                  Text(
                    'isBot: ${account.isBot}',
                  ),
                  Text(
                    'createdAt: ${account.createdAt}',
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}