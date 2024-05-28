import 'package:aadj/env.dart';
import 'package:aadj/instance_settings.dart';
import 'package:flutter/material.dart';
import 'widgets/auth.dart';
import 'myapp.dart';

void main() => runApp(const SignupPage()); // MyApp());
//todo ASK ABOUT NOTIFICATIONS PROBLEM
//todo ASK ABOUT USER PAGE PROBLEM
//
// import 'package:mastodon_oauth2/mastodon_oauth2.dart';
//
// void main() {
//   runApp(const MaterialApp(home: Example()));
// }
//
// class Example extends StatefulWidget {
//   const Example({Key? key}) : super(key: key);
//
//   @override
//   State<Example> createState() => _ExampleState();
// }
//
// class _ExampleState extends State<Example> {
//   String? _accessToken;
//   String? _refreshToken;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Access Token: $_accessToken'),
//               ElevatedButton(
//                 onPressed: () async {
//                   final oauth2 = MastodonOAuth2Client(
//                     // Specify mastodon instance like "mastodon.social"
//                     instance: instance,
//                     clientId: Env.clientKey,
//                     clientSecret: Env.clientSecret,
//
//                     // Replace redirect url as you need.
//                     redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
//                     customUriScheme: 'org.example.oauth',
//                   );
//
//                   final response = await oauth2.executeAuthCodeFlow(
//                     scopes: [
//                       Scope.read,
//                       Scope.write,
//                       Scope.follow,
//                       Scope.push,
//                     ],
//                   );
//
//                   super.setState(() {
//                     _accessToken = response.accessToken;
//                   });
//                 },
//                 child: const Text('Push!'),
//               )
//             ],
//           ),
//         ),
//       );
// }
