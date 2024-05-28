import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CLIENTKEY', defaultValue: '', obfuscate: true)
  static String clientKey = _Env.clientKey;
  @EnviedField(varName: 'CLIENTSECRET', defaultValue: '', obfuscate: true)
  static String clientSecret = _Env.clientSecret;
}
