import 'dart:async';

import 'package:aadj/auth.dart';
import 'package:aadj/env.dart';
import 'package:aadj/globals.dart';
import 'package:aadj/instance_settings.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart' as m;
import 'myapp.dart';
import 'package:mastodon_oauth2/mastodon_oauth2.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:oauth2_client/oauth2_client.dart';

// //todo ASK ABOUT NOTIFICATIONS PROBLEM

void main() {
  runApp(const MaterialApp(home: Example())); //MyApp
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  String? _accessToken;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Access Token: $_accessToken'),
              ElevatedButton(
                onPressed: () async {
                  final oauth2 = MastodonOAuth2Client(
                    instance: instance,
                    clientId: Env.clientKey,
                    clientSecret: Env.clientSecret,
                    redirectUri: Env.redirectURI,
                    customUriScheme: 'http://localhost:8080',
                  );

                  final response = await oauth2.executeAuthCodeFlow(
                    scopes: [Scope.read, Scope.write, Scope.follow, Scope.push],
                  );
                  _accessToken = response.accessToken;
                  print(response.toJson()['access_token']);
                  m.MastodonApi msapi = m.MastodonApi(
                      instance: instance, bearerToken: response.accessToken);
                  final acct = msapi.v1.accounts.verifyAccountCredentials(
                      bearerToken: response.accessToken);
                  print(acct.toString());
                  super.setState(() {
                    _accessToken = response.accessToken;
                  });
                },
                child: const Text('Push!'),
              ),
              TextFormField(
                onChanged: (value) {
                  auth(value);
                },
              ),
            ],
          ),
        ),
      );
}

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
//   String? _userId;
//   final _authCodeController = TextEditingController();
//
//   @override
//   void dispose() {
//     _authCodeController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Access Token: $_accessToken'),
//               Text('User ID: $_userId'),
//               TextField(
//                 controller: _authCodeController,
//                 decoration:
//                     const InputDecoration(labelText: 'Authorization Code'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final authCode = _authCodeController.text;
//                   if (authCode.isEmpty) {
//                     return;
//                   }
//
//                   final oauth2 = MastodonOAuth2Client(
//                     instance: instance,
//                     clientId: Env.clientKey,
//                     clientSecret: Env.clientSecret,
//                     redirectUri: 'org.example.aadj://callback/',
//                     customUriScheme: 'http://localhost:8080',
//                   );
//
//                   final response = await oauth2.executeAuthCodeFlow(
//                     authCode: authCode,
//                     scopes: [Scope.read, Scope.write, Scope.follow, Scope.push],
//                   );
//                   print(response);
//
//                   final mastodonApi = MastodonApi(
//                     accessToken: response.accessToken,
//                     instanceUrl: instance.uri.toString(),
//                   );
//                   final account = await mastodonApi.getAccount();
//                   print(account.id);
//                   super.setState(() {
//                     _accessToken = response.accessToken;
//                     _userId = account.id.toString();
//                   });
//                 },
//                 child: const Text('Login with Code'),
//               )
//             ],
//           ),
//         ),
//       );
// }
