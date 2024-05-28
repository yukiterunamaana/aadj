import 'package:aadj/env.dart';
import 'package:aadj/instance_settings.dart';
import 'package:flutter/material.dart';
import 'myapp.dart';
import 'package:mastodon_oauth2/mastodon_oauth2.dart';
//import 'package:mastodon_api/mastodon_api.dart';

// void main() => runApp(const MyApp()); //SignupPage());
// //todo ASK ABOUT NOTIFICATIONS PROBLEM
// //todo ASK ABOUT USER PAGE PROBLEM

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  String? _accessToken;
  String? _refreshToken;
  //MastodonClient? _mastodonClient;
  String? _instance;

  // Input fields for instance, username, password
  final _instanceController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _instanceController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Input field for Instance
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _instanceController,
                  decoration: const InputDecoration(labelText: 'Instance'),
                ),
              ),

              // Input field for Username
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ),

              // Input field for Password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
              ),

              // Button for logging in
              ElevatedButton(
                onPressed: () async {
                  _instance = _instanceController.text;
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // 1. Authenticate using MastodonOAuth2Client
                  final oauth2 = MastodonOAuth2Client(
                    instance: _instance!,
                    clientId: Env.clientKey,
                    clientSecret: Env.clientSecret,
                    redirectUri: 'aadj://callback',
                    customUriScheme: 'http://localhost:8080',
                  );
                  try {
                    final response = await oauth2.executeAuthCodeFlow(
                      scopes: [
                        Scope.read,
                        Scope.write,
                        Scope.follow,
                        Scope.push,
                      ],
                    );
                    print(response);
                    _accessToken = response.accessToken;
                    //_refreshToken = response.refreshToken;
                    print('Access Token: $_accessToken');
                    //print('Refresh Token: $_refreshToken');

                    // // 2. Create a MastodonClient instance
                    // _mastodonClient = MastodonClient(
                    //   instance: _instance!,
                    //   accessToken: _accessToken!,
                    // );

                    // // 3. Fetch user information
                    // final user = await _mastodonClient!.currentUser();
                    // print('User ID: ${user.id}');
                    // print('User Username: ${user.username}');
                  } catch (e) {
                    print('Error during authentication: $e');
                  }
                },
                child: const Text('Login'),
              ),

              // Display the Access Token
              //Text('Access Token: $_accessToken'),

              // Display the Refresh Token
              //Text('Refresh Token: $_refreshToken'),
            ],
          ),
        ),
      );
}
//
// // import 'package:aadj/env.dart';
// // import 'package:aadj/instance_settings.dart';
// // import 'package:flutter/material.dart';
// // import 'myapp.dart';
// // import 'package:mastodon_oauth2/mastodon_oauth2.dart';
// //
// // // void main() => runApp(const SignupPage()); // MyApp());
// // // //todo ASK ABOUT NOTIFICATIONS PROBLEM
// // // //todo ASK ABOUT USER PAGE PROBLEM
// //
// // void main() {
// //   runApp(const MaterialApp(home: Example()));
// // }
// //
// // class Example extends StatefulWidget {
// //   const Example({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Example> createState() => _ExampleState();
// // }
// //
// // class _ExampleState extends State<Example> {
// //   String? _accessToken;
// //   String? _refreshToken;
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Text('Access Token: $_accessToken'),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   final oauth2 = MastodonOAuth2Client(
// //                     // Specify mastodon instance like "mastodon.social"
// //                     instance: instance,
// //                     clientId: Env.clientKey,
// //                     clientSecret: Env.clientSecret,
// //
// //                     // Replace redirect url as you need.
// //                     redirectUri: 'aadj://callback',
// //                     customUriScheme: 'http://localhost:8080',
// //                   );
// //
// //                   final response = await oauth2.executeAuthCodeFlow(
// //                     scopes: [
// //                       Scope.read,
// //                       Scope.write,
// //                       Scope.follow,
// //                       Scope.push,
// //                     ],
// //                   );
// //
// //                   super.setState(() {
// //                     _accessToken = response.accessToken;
// //                     print(_accessToken);
// //                   });
// //                 },
// //                 child: const Text('Push!'),
// //               )
// //             ],
// //           ),
// //         ),
// //       );
// // }
