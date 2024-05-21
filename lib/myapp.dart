import 'package:aadj/widgets/bottom_navigation_bar.dart';
import 'package:aadj/widgets/notif_receiver.dart';
import 'package:aadj/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    fetchNotifications();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: //AccountWidget(accountId: myAccount,)
            const AppBottomBar());

    //const NotificationWidget(notificationId: '275311914'));
  }
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: //AccountWidget(accountId: myAccount,)
//           ComposeStatusWidget(), //NotificationPageWidget(),
//       //HomePageWidget(),
//       //MastodonPostView(
//       //     statusId: '112423096960509063'), //'112366576807601174'),
//       //'112365754229630507'),
//     );
//   }
// }
