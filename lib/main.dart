import 'package:aadj/globals.dart';
import 'package:aadj/home_page.dart';
import 'package:aadj/post_view.dart';
import 'package:aadj/state_preservation.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import 'account_view.dart';
import 'bottom_nav_bar.dart';
import 'key.dart';
import 'new_pagination.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: //AccountWidget(accountId: myAccount,)//MastodonReel(mastodonApi: mstdn,),//
       const //StatusWidget(statusId: '112366576807601174'),
        HomePaginationWidget(),//'112365754229630507'),
    );
  }
}