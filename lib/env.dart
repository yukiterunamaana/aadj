import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'MASTODON_APP_KEY')
  static const String mastodonAppKey = _Env.mastodonAppKey;

  @EnviedField(varName: 'MASTODON_APP_SECRET')
  static const String mastodonAppSecret = _Env.mastodonAppSecret;

  @EnviedField(varName: 'MASTODON_USER_TOKEN')
  static const String mastodonUserToken = _Env.mastodonUserToken;

  @EnviedField(varName: 'REDIRECT_URI')
  static const String redirectUri = _Env.redirectUri;
}
