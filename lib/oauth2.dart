import 'package:mastodon_api/mastodon_api.dart';
import 'package:mastodon_oauth2/mastodon_oauth2.dart';

class MastodonOAuth2Client {
  final String _mastodonInstance;
  final String _clientId;
  final String _clientSecret;
  final String _redirectUri;

  MastodonOAuth2Client({
    required String mastodonInstance,
    required String clientId,
    required String clientSecret,
    required String redirectUri,
  })  : _mastodonInstance = mastodonInstance,
        _clientId = clientId,
        _clientSecret = clientSecret,
        _redirectUri = redirectUri;

  Future<void> authorize() async {
    final oauth2 = MastodonOAuth2Client(
      mastodonInstance: _mastodonInstance,
      clientId: _clientId,
      clientSecret: _clientSecret,
      redirectUri: _redirectUri,
    );
    // Use the token to authenticate with the Mastodon API
  }
}
