// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:datex/features/splash/splash_screen.dart' as _i1;
import 'package:datex/features/unboarding/unboarding_choose_screen.dart' as _i2;
import 'package:datex/features/unboarding/unboarding_screen.dart' as _i3;

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.SplashPage();
    },
  );
}

/// generated route for
/// [_i2.UnboardingChooseScreen]
class UnboardingChooseRoute extends _i4.PageRouteInfo<void> {
  const UnboardingChooseRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UnboardingChooseRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingChooseRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.UnboardingChooseScreen();
    },
  );
}

/// generated route for
/// [_i3.UnboardingScreen]
class UnboardingRoute extends _i4.PageRouteInfo<void> {
  const UnboardingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.UnboardingScreen();
    },
  );
}
