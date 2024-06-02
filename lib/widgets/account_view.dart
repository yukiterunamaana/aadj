import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mastodon_api/mastodon_api.dart';
import '../core/globals.dart';

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
                  animationsEnabled
                      ? Image.network(account.header)
                      : Image.network(account.headerStatic),
                  animationsEnabled
                      ? Image.network(account.avatar)
                      : Image.network(account.avatarStatic),
                  Text(
                    account.username,
                    style: tagStyle,
                  ),
                  Text(
                    account.displayName,
                    style: tagStyle,
                  ),

                  account.acct != account.username
                      ? Text(
                          account.acct,
                          style: tagStyle,
                        )
                      : Text(''),
                  Text(
                    account.note,
                    style: tagStyle,
                  ),
                  Text('${account.followersCount} followers'),
                  Text('${account.followingCount} followings'),
                  Text('${account.statusesCount} statuses'),
                  Column(
                    children: account.fields.map((entry) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(entry.name,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Expanded(
                              flex: 7,
                              child: HtmlWidget(entry.value),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                      'Created at: ${account.createdAt.month}/${account.createdAt.day}/${account.createdAt.year}')

                  //@JsonKey(name: 'locked') bool? isLocked,
                  //@JsonKey(name: 'bot') bool? isBot,

                  /// When the most recent status was posted.
                  //DateTime? lastStatusAt,
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
