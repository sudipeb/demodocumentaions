import 'package:auto_route/auto_route.dart';
import 'package:demodoumentation/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignInRoute.page, initial: true, path: '/'),
    AutoRoute(page: UserDetailsRoute.page),
  ];
}
