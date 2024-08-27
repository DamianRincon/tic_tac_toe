import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:tic_tac_toe/src/core/utils/string_extentions.dart";

import "../../../../core/repository/sign_up_service.dart";

///
const String signUpTag = "sign_up_tag";

///
class SignUpController extends GetxController {
  ///
  FocusNode passwordFocus = FocusNode();

  ///
  FocusNode emailFocus = FocusNode();

  ///
  RxBool showPassword = false.obs;

  ///
  RxBool showButton = false.obs;

  ///
  TextEditingController userNameController = TextEditingController();

  ///
  TextEditingController emailController = TextEditingController();

  ///
  TextEditingController passwordController = TextEditingController();

  ///
  final SignUpService _service = SignUpService();

  ///
  final RxString errorMessage = "".obs;

  @override
  void onInit() {
    passwordFocus.addListener(listenerFocus);
    super.onInit();
  }

  ///
  Future<void> signup(String username, String email, String password) async {
    await _service.signup(
      emailAddress: email,
      password: password,
      userName: username,
    );
  }

  ///
  void validate() {
    final String userName = userNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isNotNullOrEmpty() ||
        password.isNotNullOrEmpty() ||
        userName.isNotNullOrEmpty()) {
      if (email.isEmailValid()) {
        signup(userName, email, password);
      } else {
        errorMessage.value = "Email no valido";
      }
    } else {
      errorMessage.value = "Campos vacios";
    }
  }

  @override
  void onClose() {
    passwordFocus
      ..dispose()
      ..removeListener(listenerFocus);
    super.onClose();
  }

  ///
  void listenerFocus() {
    showButton(passwordFocus.hasFocus);
  }
}
