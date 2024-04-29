import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';
//import 'package:mastodon_api/account.dart';
import 'globals.dart';
import 'key.dart';

class AccountPropertiesWidget extends StatefulWidget {
  final String accountId;

  const AccountPropertiesWidget({Key? key, required this.accountId})
      : super(key: key);

  @override
  _AccountPropertiesWidgetState createState() =>
      _AccountPropertiesWidgetState();
}

class _AccountPropertiesWidgetState extends State<AccountPropertiesWidget> {
  //late String _account = '';
  late Future<Account> _account;
  //Future<MastodonResponse<Account>> lookupAccount({required String accountId})
  @override
  void initState() {
    super.initState();
    _fetchAccount();
  }

  Future<void> _fetchAccount() async {
    final mastodon = MastodonApi(
      instance: instance,
      bearerToken: key,
    );

    try {
      _account = (await mastodon.v1.accounts
          .lookupAccount(accountId: widget.accountId)) as Future<Account>;
    } on MastodonException catch (e) {
      print(e.toString());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Properties',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(_account.toString()),
            // Text(
            //   'ID: ${_account.id}',
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'Username: ${_account.username}',
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'Display Name: ${_account.displayName}',
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'URL: ${_account.url}',
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   'Description: ${_account.note}',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
