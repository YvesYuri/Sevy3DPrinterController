import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sevy_3d_printer_controller/app/core/widgets/button_widget.dart';
import 'package:sevy_3d_printer_controller/app/modules/authentication/authentication_controller.dart';
import 'package:sevy_3d_printer_controller/app/modules/authentication/widgets/forgot_password_widget.dart';
import 'package:sevy_3d_printer_controller/app/modules/authentication/widgets/sign_up_widet.dart';

import '../../../core/theme/colors_theme.dart';
import '../../../core/theme/images_theme.dart';
import '../../../core/widgets/text_field_widget.dart';

// ignore: must_be_immutable
class SignInWidget extends StatelessWidget {
  AuthenticationController? authenticationController;
  SignInWidget({required this.authenticationController, super.key});

  void showToastMessage(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey.withOpacity(0.2),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
              ),
              toolbarHeight: 120,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: SvgPicture.asset(
                        ImagesTheme.logo,
                        height: 56,
                        width: 56,
                      )),
                  const SizedBox(width: 5),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sevy',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                      Text('3D Printer Controller',
                          style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 32,
                  // ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sign in',
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: ColorsTheme.textColor)),
                    ],
                  ),
                  const SizedBox(
                    height: 58,
                  ),
                  TextFieldWidget(
                    hint: 'email@example.com',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: authenticationController!.emailSignInController,
                  ),
                  const SizedBox(height: 22),
                  Obx(() {
                    return TextFieldWidget(
                      hint: '********',
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icons.lock,
                      suffixIcon: authenticationController!
                              .isSignInPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: authenticationController!
                          .isSignInPasswordVisible.value,
                      onPressedSuffixIcon: () {
                        authenticationController!
                            .changeSignInPasswordVisibility();
                      },
                      controller:
                          authenticationController!.passwordSignInController,
                    );
                  }),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Get.to(
                              () => ForgotPasswordWidget(
                                    authenticationController:
                                        authenticationController,
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.2),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        child: const Text('Forgot password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: ColorsTheme.textColor,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ButtonWidget(
                      text: "Sig in",
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (authenticationController!.validateSignIn()) {
                          await authenticationController!
                              .signIn()
                              .then((value) {
                            if (value != null) {
                              showToastMessage(context, value);
                            }
                          });
                        } else {
                          showToastMessage(context, 'Please fill all fields');
                        }
                      }),
                  const SizedBox(height: 44),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.to(
                          () => SignUpWidget(
                                authenticationController:
                                    authenticationController,
                              ),
                          transition: Transition.rightToLeft);
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(0.2),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: const Text("Don't have account? Sign up",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: ColorsTheme.textColor,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          return Visibility(
            visible: authenticationController!.isLoading.value,
            child: Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  // borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
