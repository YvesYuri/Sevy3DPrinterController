import 'package:get/get.dart';

import '../modules/authentication/authentication_binding.dart';
import '../modules/authentication/authentication_page.dart';

class AuthenticationRoutes {
  AuthenticationRoutes._();

  static const authentication = '/authentication';

  static final routes = [
    GetPage(
      name: authentication,
      page: () => AuthenticationPage(),
      binding: AuthenticationBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
