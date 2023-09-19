import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sevy_3d_printer_controller/app/core/widgets/button_widget.dart';

import '../../../core/theme/colors_theme.dart';
import '../../../core/theme/images_theme.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../authentication_controller.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatelessWidget {
  AuthenticationController? authenticationController;
  SignUpWidget({this.authenticationController, super.key});

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
                      Text('Sign up',
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
                    hint: 'name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.name,
                    controller:
                        authenticationController!.displayNameSignUpController,
                  ),
                  const SizedBox(height: 22),
                  TextFieldWidget(
                    hint: 'e-mail',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: authenticationController!.emailSignUpController,
                  ),
                  const SizedBox(height: 22),
                  TextFieldWidget(
                    hint: 'password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    controller:
                        authenticationController!.passwordSignUpController,
                  ),
                  const SizedBox(height: 22),
                  TextFieldWidget(
                    hint: 'confirm password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    controller: authenticationController!
                        .confirmPasswordSignUpController,
                  ),
                  const SizedBox(height: 44),
                  ButtonWidget(
                      text: "Sign up",
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (authenticationController!.validateSignUp()) {
                          await authenticationController!
                              .signUp()
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
                      Get.back();
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
                    child: const Text("Have account? Sign ip",
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
