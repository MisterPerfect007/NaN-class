import 'package:google_sign_in/google_sign_in.dart';

const String googleClientId =
    '342579524909-ip6rf92vnse3n7bfid8e7s4aud2vajf2.apps.googleusercontent.com';

class GoogleAuth {
  static Future<GoogleSignInAccount?> signIn() async {
    final googleSignIn = GoogleSignIn(serverClientId: googleClientId);
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;
    return googleUser;
  }
}
