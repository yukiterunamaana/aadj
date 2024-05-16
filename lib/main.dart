import 'package:aadj/pages/notification_page.dart';
import 'package:aadj/widgets/post_thread_view.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

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
      home: //AccountWidget(accountId: myAccount,)
          NotificationPageWidget(),
      //HomePageWidget(),
      //MastodonPostView(
      //     statusId: '112423096960509063'), //'112366576807601174'),
      //'112365754229630507'),
    );
  }
}
