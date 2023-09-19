import 'package:get/get.dart';

import '../../data/services/authentication_services.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationServices());
  }
}
