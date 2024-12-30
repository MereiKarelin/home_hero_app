// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:datex/features/auth/auth_screen.dart' as _i2;
import 'package:datex/features/core/auth_utils.dart' as _i11;
import 'package:datex/features/event/add_event_screen.dart' as _i1;
import 'package:datex/features/main/main_screen.dart' as _i3;
import 'package:datex/features/main/second_main/second_main_screen.dart' as _i4;
import 'package:datex/features/splash/splash_screen.dart' as _i5;
import 'package:datex/features/unboarding/unboarding_choose_screen.dart' as _i6;
import 'package:datex/features/unboarding/unboarding_screen.dart' as _i7;
import 'package:datex/features/uncoming_events/uncoming_events_screen.dart'
    as _i8;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i9.PageRouteInfo<void> {
  const AddEventRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AddEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddEventScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i9.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i10.Key? key,
    required String country,
    required _i11.AuthType authType,
    required _i11.UserType userType,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            key: key,
            country: country,
            authType: authType,
            userType: userType,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>();
      return _i2.AuthScreen(
        key: args.key,
        country: args.country,
        authType: args.authType,
        userType: args.userType,
      );
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    required this.country,
    required this.authType,
    required this.userType,
  });

  final _i10.Key? key;

  final String country;

  final _i11.AuthType authType;

  final _i11.UserType userType;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, country: $country, authType: $authType, userType: $userType}';
  }
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i9.PageRouteInfo<void> {
  const MainRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainScreen();
    },
  );
}

/// generated route for
/// [_i4.SecondMainScreen]
class SecondMainRoute extends _i9.PageRouteInfo<SecondMainRouteArgs> {
  SecondMainRoute({
    _i10.Key? key,
    required DateTime selectedDate,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          SecondMainRoute.name,
          args: SecondMainRouteArgs(
            key: key,
            selectedDate: selectedDate,
          ),
          initialChildren: children,
        );

  static const String name = 'SecondMainRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecondMainRouteArgs>();
      return _i4.SecondMainScreen(
        key: args.key,
        selectedDate: args.selectedDate,
      );
    },
  );
}

class SecondMainRouteArgs {
  const SecondMainRouteArgs({
    this.key,
    required this.selectedDate,
  });

  final _i10.Key? key;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'SecondMainRouteArgs{key: $key, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [_i5.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i10.Key? key,
    bool? isWelcomScreen,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            isWelcomScreen: isWelcomScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SplashRouteArgs>(orElse: () => const SplashRouteArgs());
      return _i5.SplashPage(
        key: args.key,
        isWelcomScreen: args.isWelcomScreen,
      );
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    this.isWelcomScreen,
  });

  final _i10.Key? key;

  final bool? isWelcomScreen;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, isWelcomScreen: $isWelcomScreen}';
  }
}

/// generated route for
/// [_i6.UnboardingChooseScreen]
class UnboardingChooseRoute extends _i9.PageRouteInfo<void> {
  const UnboardingChooseRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UnboardingChooseRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingChooseRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.UnboardingChooseScreen();
    },
  );
}

/// generated route for
/// [_i7.UnboardingScreen]
class UnboardingRoute extends _i9.PageRouteInfo<void> {
  const UnboardingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.UnboardingScreen();
    },
  );
}

/// generated route for
/// [_i8.UncomingEventsScreen]
class UncomingEventsRoute extends _i9.PageRouteInfo<void> {
  const UncomingEventsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UncomingEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UncomingEventsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.UncomingEventsScreen();
    },
  );
}
