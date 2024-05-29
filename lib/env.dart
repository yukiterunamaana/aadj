import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CLIENTKEY', obfuscate: true)
  static String clientKey = _Env.clientKey;
  @EnviedField(varName: 'CLIENTSECRET', obfuscate: true)
  static String clientSecret = _Env.clientSecret;
  @EnviedField(varName: 'REDIRECTURI', obfuscate: true)
  static String redirectURI = _Env.redirectURI;
}
