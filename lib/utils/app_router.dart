import 'package:auto_route/auto_route.dart';
import 'package:homehero/utils/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: UnboardingRoute.page, path: '/unboarding'),
        AutoRoute(page: UnboardingChooseRoute.page, path: '/unboarding/start'),
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page, path: '/unboarding/start/auth'),
        AutoRoute(page: MainRoute.page, path: '/main'),
        AutoRoute(page: SecondMainRoute.page, path: '/main/second'),
        AutoRoute(page: UncomingEventsRoute.page, path: '/main/uncomingEvents'),
        AutoRoute(page: AddEventRoute.page, path: '/main/addEvent'),
        AutoRoute(page: FollowingRoute.page, path: '/main/following'),
        AutoRoute(page: ProfileRoute.page, path: '/main/profile'),
        AutoRoute(page: ExtraEventRoute.page, path: '/main/extraEvents'),
        AutoRoute(page: NotificationsRoute.page, path: '/main/extraEvents'),
        AutoRoute(page: SubscriptionSelectionRoute.page, path: '/main/subscriptions'),
        AutoRoute(page: SubscriptionPaymentRoute.page, path: '/main/subscriptions/payment')
      ];
}
