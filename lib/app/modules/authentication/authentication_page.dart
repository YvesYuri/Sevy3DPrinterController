import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sevy_3d_printer_controller/app/modules/authentication/widgets/sign_in_widget.dart';

import 'authentication_controller.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
  AuthenticationPage({super.key});

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return SignInWidget(
      authenticationController: authenticationController,
    );
  }
}
