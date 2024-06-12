import 'package:aadj/widgets/bottom_navigation_bar.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //final _appLinks = AppLinks();

//     Future<String> result = FlutterWebAuth2.authenticate(
//         url: "https://mastodon.social/auth/sign_in",
//         callbackUrlScheme: "org.example.aadj://callback/");
// // Extract token from resulting url
//     final token = Uri.parse(result.toString()).queryParameters['token'];
//     print(token);

    //fetchNotifications();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: //AccountWidget(accountId: myAccount,)
          const AppBottomBar(), //StatusWidget(statusId: '112525480179409844') //AppBottomBar()
    );

    //const NotificationWidget(notificationId: '275311914'));
  }
}
