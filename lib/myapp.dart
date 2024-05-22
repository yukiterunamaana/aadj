import 'package:aadj/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //fetchNotifications();
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
