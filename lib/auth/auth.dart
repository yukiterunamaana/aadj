import 'package:http/http.dart' as http;
import '../../core/env.dart';
import '../core/globals.dart';

void auth(String code) async {
  final url = Uri.parse('https://${instance}/oauth/token');

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
