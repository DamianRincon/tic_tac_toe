import "dart:developer";

import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:tic_tac_toe/src/core/utils/app_info.dart";

///
class SignInService {
  ///
  Future<User?> login(
      {required String emailAddress, required String password}) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        log("No user found for that email.");
      } else if (e.code == "wrong-password") {
        log("Wrong password provided for that user.");
      }
      log(e.toString());
      return null;
    }
  }

  ///
  Future<User?> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"],
        clientId: AppInfo.googleClientID,
      ).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        log("No user found for that email.");
      } else if (e.code == "wrong-password") {
        log("Wrong password provided for that user.");
      }
      return null;
    }
  }
}
