import "dart:developer";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:tic_tac_toe/src/core/utils/string_extentions.dart";
import 'package:loader_overlay/loader_overlay.dart';

import "../../../../core/repository/sign_in_service.dart";
import "../../../../core/routes/routes.dart";

///
const String loginControllerTag = "login_controller_tag";

///
class LoginController extends GetxController {
  ///
  FocusNode passwordFocus = FocusNode();

  ///
  RxBool showPassword = false.obs;

  ///
  RxBool showButton = false.obs;

  ///
  TextEditingController emailController = TextEditingController();

  ///
  TextEditingController passwordController = TextEditingController();

  ///
  final SignInService _service = SignInService();

  ///
  final RxString errorMessage = "".obs;

  @override
  void onInit() {
    passwordFocus.addListener(listenerFocus);
    super.onInit();
  }

  ///
  Future<void> loginWithPassword(String email, String password) async {
    Get.context!.loaderOverlay.show();
    try {
      await _service.login(
        emailAddress: email,
        password: password,
      );
      Get.context!.loaderOverlay.hide();
    } catch (error) {
      log(error.toString());
    }
  }

  ///
  Future<void> loginWithGoogle() async {
    Get.context!.loaderOverlay.show();
    try {
      await _service.loginWithGoogle();
      Get.context!.loaderOverlay.hide();
    } catch (error) {
      Get.context!.loaderOverlay.hide();
      log(error.toString());
    }
  }

  ///
  void validate() {
    final String email = emailController.text;
    final String password = passwordController.text;
    if (email.isNotNullOrEmpty() || password.isNotNullOrEmpty()) {
      if (email.isEmailValid()) {
        loginWithPassword(email, password);
      } else {
        errorMessage.value = "Email no valido";
      }
    } else {
      errorMessage.value = "Campos vacios";
    }
  }

  ///
  void goToSignUp() {
    Get.toNamed(Routes.signUp);
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
