// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:datex/data/models/event_model.dart' as _i12;
import 'package:datex/features/auth/auth_screen.dart' as _i2;
import 'package:datex/features/core/auth_utils.dart' as _i13;
import 'package:datex/features/event/add_event_screen.dart' as _i1;
import 'package:datex/features/following/following_screen.dart' as _i3;
import 'package:datex/features/main/main_screen.dart' as _i4;
import 'package:datex/features/main/second_main/second_main_screen.dart' as _i5;
import 'package:datex/features/splash/splash_screen.dart' as _i6;
import 'package:datex/features/unboarding/unboarding_choose_screen.dart' as _i7;
import 'package:datex/features/unboarding/unboarding_screen.dart' as _i8;
import 'package:datex/features/uncoming_events/uncoming_events_screen.dart'
    as _i9;
import 'package:flutter/material.dart' as _i11;

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i10.PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({
    _i11.Key? key,
    required bool isCreate,
    _i12.EventModel? eventModel,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AddEventRoute.name,
          args: AddEventRouteArgs(
            key: key,
            isCreate: isCreate,
            eventModel: eventModel,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEventRouteArgs>();
      return _i1.AddEventScreen(
        key: args.key,
        isCreate: args.isCreate,
        eventModel: args.eventModel,
      );
    },
  );
}

class AddEventRouteArgs {
  const AddEventRouteArgs({
    this.key,
    required this.isCreate,
    this.eventModel,
  });

  final _i11.Key? key;

  final bool isCreate;

  final _i12.EventModel? eventModel;

  @override
  String toString() {
    return 'AddEventRouteArgs{key: $key, isCreate: $isCreate, eventModel: $eventModel}';
  }
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i10.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i11.Key? key,
    required String country,
    required _i13.AuthType authType,
    required _i13.UserType userType,
    List<_i10.PageRouteInfo>? children,
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

  static _i10.PageInfo page = _i10.PageInfo(
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

  final _i11.Key? key;

  final String country;

  final _i13.AuthType authType;

  final _i13.UserType userType;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, country: $country, authType: $authType, userType: $userType}';
  }
}

/// generated route for
/// [_i3.FollowingScreen]
class FollowingRoute extends _i10.PageRouteInfo<void> {
  const FollowingRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FollowingRoute.name,
          initialChildren: children,
        );

  static const String name = 'FollowingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.FollowingScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.SecondMainScreen]
class SecondMainRoute extends _i10.PageRouteInfo<SecondMainRouteArgs> {
  SecondMainRoute({
    _i11.Key? key,
    required DateTime selectedDate,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SecondMainRoute.name,
          args: SecondMainRouteArgs(
            key: key,
            selectedDate: selectedDate,
          ),
          initialChildren: children,
        );

  static const String name = 'SecondMainRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecondMainRouteArgs>();
      return _i5.SecondMainScreen(
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

  final _i11.Key? key;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'SecondMainRouteArgs{key: $key, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i11.Key? key,
    bool? isWelcomScreen,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            isWelcomScreen: isWelcomScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SplashRouteArgs>(orElse: () => const SplashRouteArgs());
      return _i6.SplashPage(
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

  final _i11.Key? key;

  final bool? isWelcomScreen;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, isWelcomScreen: $isWelcomScreen}';
  }
}

/// generated route for
/// [_i7.UnboardingChooseScreen]
class UnboardingChooseRoute extends _i10.PageRouteInfo<void> {
  const UnboardingChooseRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UnboardingChooseRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingChooseRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.UnboardingChooseScreen();
    },
  );
}

/// generated route for
/// [_i8.UnboardingScreen]
class UnboardingRoute extends _i10.PageRouteInfo<void> {
  const UnboardingRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.UnboardingScreen();
    },
  );
}

/// generated route for
/// [_i9.UncomingEventsScreen]
class UncomingEventsRoute extends _i10.PageRouteInfo<void> {
  const UncomingEventsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UncomingEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UncomingEventsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.UncomingEventsScreen();
    },
  );
}
