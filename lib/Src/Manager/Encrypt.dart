import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

class Encrypt {
  static const public = """

""";
  static Future<String> encrypt(String psw) async {
    final publicPem = await rootBundle.loadString('key/public.pem');
    dynamic publicKey = RSAKeyParser().parse(publicPem);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    var result = encrypter.encrypt(psw).base64;
    return "__RSA__$result";
  }
}
