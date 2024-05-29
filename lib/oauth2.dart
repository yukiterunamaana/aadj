// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:oauth2/oauth2.dart' as oauth2;
// import 'package:url_launcher/url_launcher.dart';
// import 'env.dart';
//
// class AuthorizationWorkflow with ChangeNotifier {
//   final String _clientId = Env.clientKey;
//   final String _clientSecret = Env.clientSecret;
//   final String _redirectUri = 'aadj://callback';
//   final String _authorizationUrl = 'https://mastodon.social/auth/sign_up';
//   final String _tokenUrl = 'https://your_instance.mastodon.cloud/oauth/token';
//
//   oauth2.Client? _client;
//
//   Future<void> authorize() async {
//     final authorizationUrl = Uri.parse('$_authorizationUrl?'
//         'client_id=$_clientId&'
//         'redirect_uri=$_redirectUri&'
//         'response_type=code&'
//         'scope=read write follow push');
//
//     if (await canLaunchUrl(authorizationUrl)) {
//       await launchUrl(authorizationUrl);
//     } else {
//       throw 'Could not launch $authorizationUrl';
//     }
//   }
//
//   Future<void> handleAuthorizationResponse(Uri url) async {
//     final code = url.queryParameters['code'];
//
//     if (code != null) {
//       final tokenResponse = await http.post(
//         Uri.parse(_tokenUrl),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'grant_type': 'authorization_code',
//           'code': code,
//           'redirect_uri': _redirectUri,
//           'client_id': _clientId,
//           'client_secret': _clientSecret,
//         },
//       );
//
//       final json = jsonDecode(tokenResponse.body);
//
//       final token =
//           oauth2.AccessToken(json['access_token'], json['token_type']);
//
//       _client = oauth2.Client(
//         token,
//         identifier: _clientId,
//         secret: _clientSecret,
//       );
//
//       notifyListeners();
//     } else {
//       throw 'No authorization code found';
//     }
//   }
//
//   Future<http.Response> getTimeline() async {
//     if (_client != null) {
//       final response = await _client!.get(Uri.parse(
//           'https://your_instance.mastodon.cloud/api/v1/timelines/home'));
//
//       return response;
//     } else {
//       throw 'Not authorized';
//     }
//   }
// }
