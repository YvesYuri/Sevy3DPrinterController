import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/authentication_services.dart';

class AuthenticationController extends GetxController {
  final authenticationService = Get.find<AuthenticationServices>();

  final isLoading = false.obs;

  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
  TextEditingController displayNameSignUpController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController confirmPasswordSignUpController =
      TextEditingController();
  TextEditingController emailForgotPasswordController = TextEditingController();

  final isSignInPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    authenticationService.authStateChanges.listen((user) {
      if (user == null) {
        Get.offNamed('/authentication');
      } else {
        Get.offNamed('/dashboard');
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeSignInPasswordVisibility() {
    isSignInPasswordVisible.value = !isSignInPasswordVisible.value;
  }

  bool validateSignIn() {
    if (passwordSignInController.text.length < 6 ||
        !EmailValidator.validate(emailSignInController.text)) {
      return false;
    } else {
      return true;
    }
  }

  bool validateSignUp() {
    if ((displayNameSignUpController.text.length < 4) ||
        (!EmailValidator.validate(emailSignUpController.text)) ||
        (passwordSignUpController.text.length < 6) ||
        (passwordSignUpController.text !=
            confirmPasswordSignUpController.text)) {
      return false;
    } else {
      return true;
    }
  }

  bool validateForgotPassword() {
    if (!EmailValidator.validate(emailForgotPasswordController.text)) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> signIn() async {
    isLoading.value = true;
    var result = await authenticationService.signIn(
        emailSignInController.text, passwordSignInController.text);
    if (result.$1 == null) {
      isLoading.value = false;
      return result.$2;
    } else {
      isLoading.value = false;
      return null;
    }
  }

  Future<String?> signUp() async {
    isLoading.value = true;
    var result = await authenticationService.signUp(
      emailSignUpController.text,
      passwordSignUpController.text,
      displayNameSignUpController.text,
    );
    if (result.$1 == null) {
      isLoading.value = false;
      return result.$2;
    } else {
      isLoading.value = false;
      return null;
    }
  }

  Future<String?> forgotPassword() async {
    isLoading.value = true;
    var result = await authenticationService
        .forgotPassword(emailForgotPasswordController.text);
    if (result == null) {
      isLoading.value = false;
      return null;
    } else {
      isLoading.value = false;
      return result;
    }
  }
}
