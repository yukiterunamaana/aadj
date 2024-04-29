import 'package:aadj/globals.dart';
import 'package:aadj/state_preservation.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import 'account_view.dart';
import 'bottom_nav_bar.dart';
import 'key.dart';

// Future<void> main() async {
//   //! You need to specify mastodon instance (domain) you want to access.
//   //! Also you need to get bearer token from your developer page, or OAuth 2.0.
//   final mastodon = MastodonApi(
//     instance: instance,
//     bearerToken: key,
//
//     //! Automatic retry is available when server error or network error occurs
//     //! when communicating with the API.
//     retryConfig: RetryConfig(
//       maxAttempts: 5,
//       jitter: Jitter(
//         minInSeconds: 2,
//         maxInSeconds: 5,
//       ),
//       onExecute: (event) => print(
//         'Retry after ${event.intervalInSeconds} seconds... '
//             '[${event.retryCount} times]',
//       ),
//     ),
//
//     //! The default timeout is 10 seconds.
//     timeout: Duration(seconds: 20),
//   );
//
//   try {
//     //! Let's Toot from v1 endpoint!
//     final response = await mastodon.v1.statuses.createStatus(
//       text: 'Toot!',
//     );
//
//     print(response.rateLimit);
//     print(response.data);
//   } on UnauthorizedException catch (e) {
//     print(e);
//   } on RateLimitExceededException catch (e) {
//     print(e);
//   } on MastodonException catch (e) {
//     print(e.response);
//     print(e.body);
//     print(e);
//   }
// }
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
      home: const AccountPropertiesWidget(
        accountId: '107967425890886119',
      ),
    );
  }
}
