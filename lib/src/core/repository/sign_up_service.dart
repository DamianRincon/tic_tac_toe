import "dart:developer";

import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";

///
class SignUpService {
  ///
  Future<Map<String, dynamic>> signup({
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    final Map<String, dynamic> _result = <String, dynamic>{};
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(userName);
      }
      _result["code"] = 200;
      _result["message"] = "";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        _result["code"] = "201";
        _result["message"] = "password_weak".tr;
        log("The password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        _result["code"] = "204";
        _result["message"] = "existent_account".tr;
        log("The account already exists for that email.");
      }
    } catch (e) {
      _result["code"] = "500";
      _result["message"] = "error_service".tr;
      log(e.toString());
    }
    return _result;
  }
}
