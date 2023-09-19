import 'home_routes.dart';
import 'authentication_routes.dart';
import 'dashboard_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/authentication';

  static final routes = [
    ...HomeRoutes.routes,
		...AuthenticationRoutes.routes,
		...DashboardRoutes.routes,
  ];
}
