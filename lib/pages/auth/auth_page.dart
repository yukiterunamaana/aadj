import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart' as m;
import 'package:mastodon_oauth2/mastodon_oauth2.dart';

import '../../auth.dart';
import '../../env.dart';
import '../../instance_settings.dart';
import '../../widgets/bottom_navigation_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? _accessToken;
  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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

                  //print(response.toJson()['access_token']);
                  m.MastodonApi msapi = m.MastodonApi(
                      instance: instance, bearerToken: response.accessToken);
                  final acct = msapi.v1.accounts.verifyAccountCredentials(
                      bearerToken: response.accessToken);
                  //print(acct.toString());
                  super.setState(() {
                    _accessToken = response.accessToken;
                  });
                },
                child: const Text('Authenticate on mastodon.social'),
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              IconButton(
                onPressed: () {
                  auth(_controller.value.text);
                  _controller.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppBottomBar()),
                  );
                  // if (!response.toJson().containsKey("error")) {
                  //   final api = m.MastodonApi(
                  //     instance: instance,
                  //     bearerToken: response.accessToken,
                  //   );
                  //   final verifyResponse =
                  //       await api.v1.accounts.verifyAccountCredentials();
                  //   print(verifyResponse);
                  //   if (!verifyResponse.headers.containsKey("error")) {
                  //     // store the access token
                  //     const storage = FlutterSecureStorage();
                  //     await storage.write(
                  //       key: 'bearer_token',
                  //       value: response.accessToken,
                  //     );
                  //     // navigate to the main menu
                  //
                  //   }
                  // }
                },
                icon: const Icon(Icons.arrow_circle_up),
                // child: ,
              ),
            ],
          ),
        ),
      );
}
