import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';
//import 'package:mastodon_api/account.dart';
import '../globals.dart';

class AccountPropertiesWidget extends StatefulWidget {
  final String accountId;

  const AccountPropertiesWidget({super.key, required this.accountId});

  @override
  _AccountPropertiesWidgetState createState() =>
      _AccountPropertiesWidgetState();
}

class _AccountPropertiesWidgetState extends State<AccountPropertiesWidget> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${account.id}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Username: ${account.username}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Display Name: ${account.displayName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Description: ${account.note}',
                    style: const TextStyle(fontSize: 16),
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
