import 'package:auto_route/auto_route.dart';
import 'package:datex/utils/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: UnboardingRoute.page, path: '/unboarding'),
        AutoRoute(page: UnboardingChooseRoute.page, path: '/unboarding/start'),
        AutoRoute(page: SplashRoute.page, initial: true),
      ];
}
