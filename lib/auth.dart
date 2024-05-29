import 'package:http/http.dart' as http;

import 'env.dart';

// import 'package:oauth2_client/oauth2_client.dart';
//
// import 'env.dart';
//
// final clientId = 'your-client-id';
// final clientSecret = 'your-client-secret';
// final redirectUri = Uri.parse('your-redirect-uri');
// final authorizeUrl =
//     Uri.parse('https://your-mastodon-instance.com/oauth/authorize');
// final tokenUrl = Uri.parse('https://your-mastodon-instance.com/oauth/token');
//
// final client = OAuth2Client(
//   clientId: Env.clientKey,
//   clientSecret: Env.clientSecret,
//   authorizeUrl: authorizeUrl,
//   tokenUrl: tokenUrl,
//   redirectUri: redirectUri,
//   customUriScheme: '',
// );
//
// final authorizationUrl = await client.accessTokenRequestHeaders(
//   scopes: ['read', 'write'],
// );
void auth(String code) async {
  final url = Uri.parse('https://mastodon.social/oauth/token');

  final req = http.MultipartRequest('POST', url)
    ..fields['grant_type'] = 'client_credentials'
    ..fields['code'] = code
    ..fields['client_id'] = Env.clientKey
    ..fields['client_secret'] = Env.clientSecret
    ..fields['redirect_uri'] = Env.redirectURI
    ..fields['scope'] = 'read write follow push';

  final stream = await req.send();
  final res = await http.Response.fromStream(stream);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.send error: statusCode= $status');

  print(res.body);
}
