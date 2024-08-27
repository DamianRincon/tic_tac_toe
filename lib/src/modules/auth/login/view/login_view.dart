import "dart:io";
import "dart:ui";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:icons_plus/icons_plus.dart";

import "../../../../core/common/colors.dart";
import "../controllers/login_controller.dart";

///
class LoginView extends GetView<LoginController> {
  ///
  const LoginView({super.key});

  @override
  String? get tag => loginControllerTag;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 35),
          child: InkWell(
            onTap: controller.goToSignUp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${"not_have_account".tr} ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "sign_up".tr,
                  style: const TextStyle(
                    color: MColors.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 50,
              right: 0,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/images/cancel.png",
                  color: MColors.secondaryContainer,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/gato-glassy.png",
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  "assets/images/circle-glassy.png",
                ),
              ),
            ),
            Positioned(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                child: Container(),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: Get.width,
                      height: 250,
                      alignment: Alignment.centerLeft,
                      child: const Hero(
                        tag: "logo",
                        child: Text(
                          "#",
                          style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "login_welcome".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "login_content".tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "email".tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: Platform.isIOS
                          ? TextInputAction.continueAction
                          : TextInputAction.go,
                      onEditingComplete: () {
                        controller.passwordFocus.requestFocus();
                      },
                      decoration: const InputDecoration(
                        filled: false,
                        isDense: true,
                        hintText: "email@example.com",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "password".tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Stack(
                        children: <Widget>[
                          TextField(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !controller.showPassword.value,
                            focusNode: controller.passwordFocus,
                            decoration: const InputDecoration(
                              filled: false,
                              isDense: true,
                              hintText: "********",
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: controller.showButton.value
                                ? IconButton(
                                    onPressed: () {
                                      controller.showPassword(
                                          !controller.showPassword.value);
                                    },
                                    icon: Icon(
                                      controller.showPassword.value
                                          ? AntDesign.eye_invisible_outline
                                          : AntDesign.eye_outline,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    TextButton(
                      onPressed: controller.validate,
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(Get.width, 55),
                        ),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: Text(
                        "login".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text("or".tr),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: IconButton(
                        onPressed: controller.loginWithGoogle,
                        icon: Brand(Brands.google),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
