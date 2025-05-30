// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/cupertino.dart' as _i20;
import 'package:flutter/material.dart' as _i16;
import 'package:homehero/data/models/event_model.dart' as _i17;
import 'package:homehero/data/models/subscription_model.dart' as _i21;
import 'package:homehero/data/models/user_info_model.dart' as _i19;
import 'package:homehero/features/auth/auth_screen.dart' as _i2;
import 'package:homehero/features/core/auth_utils.dart' as _i18;
import 'package:homehero/features/event/add_event_screen.dart' as _i1;
import 'package:homehero/features/event/extra_event_screen.dart' as _i3;
import 'package:homehero/features/following/following_screen.dart' as _i4;
import 'package:homehero/features/main/main_screen.dart' as _i5;
import 'package:homehero/features/main/second_main/second_main_screen.dart'
    as _i8;
import 'package:homehero/features/notification/notification_screen.dart' as _i6;
import 'package:homehero/features/profile/profile_screen.dart' as _i7;
import 'package:homehero/features/splash/splash_screen.dart' as _i9;
import 'package:homehero/features/subscription/subscription_payment_screen.dart'
    as _i10;
import 'package:homehero/features/subscription/subscription_select_screen.dart'
    as _i11;
import 'package:homehero/features/unboarding/unboarding_choose_screen.dart'
    as _i12;
import 'package:homehero/features/unboarding/unboarding_screen.dart' as _i13;
import 'package:homehero/features/uncoming_events/uncoming_events_screen.dart'
    as _i14;

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i15.PageRouteInfo<AddEventRouteArgs> {
  AddEventRoute({
    _i16.Key? key,
    required bool isCreate,
    _i17.EventModel? eventModel,
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  final bool isCreate;

  final _i17.EventModel? eventModel;

  @override
  String toString() {
    return 'AddEventRouteArgs{key: $key, isCreate: $isCreate, eventModel: $eventModel}';
  }
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i15.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i16.Key? key,
    required String country,
    required _i18.AuthType authType,
    required _i18.UserType userType,
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  final String country;

  final _i18.AuthType authType;

  final _i18.UserType userType;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, country: $country, authType: $authType, userType: $userType}';
  }
}

/// generated route for
/// [_i3.ExtraEventScreen]
class ExtraEventRoute extends _i15.PageRouteInfo<ExtraEventRouteArgs> {
  ExtraEventRoute({
    _i16.Key? key,
    required bool isCreate,
    _i17.EventModel? eventModel,
    required _i19.UserInfoModel userInfoModel,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ExtraEventRoute.name,
          args: ExtraEventRouteArgs(
            key: key,
            isCreate: isCreate,
            eventModel: eventModel,
            userInfoModel: userInfoModel,
          ),
          initialChildren: children,
        );

  static const String name = 'ExtraEventRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExtraEventRouteArgs>();
      return _i3.ExtraEventScreen(
        key: args.key,
        isCreate: args.isCreate,
        eventModel: args.eventModel,
        userInfoModel: args.userInfoModel,
      );
    },
  );
}

class ExtraEventRouteArgs {
  const ExtraEventRouteArgs({
    this.key,
    required this.isCreate,
    this.eventModel,
    required this.userInfoModel,
  });

  final _i16.Key? key;

  final bool isCreate;

  final _i17.EventModel? eventModel;

  final _i19.UserInfoModel userInfoModel;

  @override
  String toString() {
    return 'ExtraEventRouteArgs{key: $key, isCreate: $isCreate, eventModel: $eventModel, userInfoModel: $userInfoModel}';
  }
}

/// generated route for
/// [_i4.FollowingScreen]
class FollowingRoute extends _i15.PageRouteInfo<void> {
  const FollowingRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FollowingRoute.name,
          initialChildren: children,
        );

  static const String name = 'FollowingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.FollowingScreen();
    },
  );
}

/// generated route for
/// [_i5.MainScreen]
class MainRoute extends _i15.PageRouteInfo<void> {
  const MainRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainScreen();
    },
  );
}

/// generated route for
/// [_i6.NotificationsScreen]
class NotificationsRoute extends _i15.PageRouteInfo<NotificationsRouteArgs> {
  NotificationsRoute({
    _i20.Key? key,
    required int userId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          NotificationsRoute.name,
          args: NotificationsRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationsRouteArgs>();
      return _i6.NotificationsScreen(
        key: args.key,
        userId: args.userId,
      );
    },
  );
}

class NotificationsRouteArgs {
  const NotificationsRouteArgs({
    this.key,
    required this.userId,
  });

  final _i20.Key? key;

  final int userId;

  @override
  String toString() {
    return 'NotificationsRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i8.SecondMainScreen]
class SecondMainRoute extends _i15.PageRouteInfo<SecondMainRouteArgs> {
  SecondMainRoute({
    _i16.Key? key,
    required DateTime selectedDate,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SecondMainRoute.name,
          args: SecondMainRouteArgs(
            key: key,
            selectedDate: selectedDate,
          ),
          initialChildren: children,
        );

  static const String name = 'SecondMainRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecondMainRouteArgs>();
      return _i8.SecondMainScreen(
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

  final _i16.Key? key;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'SecondMainRouteArgs{key: $key, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i16.Key? key,
    bool? isWelcomScreen,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            isWelcomScreen: isWelcomScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SplashRouteArgs>(orElse: () => const SplashRouteArgs());
      return _i9.SplashPage(
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

  final _i16.Key? key;

  final bool? isWelcomScreen;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, isWelcomScreen: $isWelcomScreen}';
  }
}

/// generated route for
/// [_i10.SubscriptionPaymentScreen]
class SubscriptionPaymentRoute
    extends _i15.PageRouteInfo<SubscriptionPaymentRouteArgs> {
  SubscriptionPaymentRoute({
    _i16.Key? key,
    required _i21.SubscriptionTypeModel type,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SubscriptionPaymentRoute.name,
          args: SubscriptionPaymentRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'SubscriptionPaymentRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubscriptionPaymentRouteArgs>();
      return _i10.SubscriptionPaymentScreen(
        key: args.key,
        type: args.type,
      );
    },
  );
}

class SubscriptionPaymentRouteArgs {
  const SubscriptionPaymentRouteArgs({
    this.key,
    required this.type,
  });

  final _i16.Key? key;

  final _i21.SubscriptionTypeModel type;

  @override
  String toString() {
    return 'SubscriptionPaymentRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i11.SubscriptionSelectionScreen]
class SubscriptionSelectionRoute extends _i15.PageRouteInfo<void> {
  const SubscriptionSelectionRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SubscriptionSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubscriptionSelectionRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SubscriptionSelectionScreen();
    },
  );
}

/// generated route for
/// [_i12.UnboardingChooseScreen]
class UnboardingChooseRoute extends _i15.PageRouteInfo<void> {
  const UnboardingChooseRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UnboardingChooseRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingChooseRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.UnboardingChooseScreen();
    },
  );
}

/// generated route for
/// [_i13.UnboardingScreen]
class UnboardingRoute extends _i15.PageRouteInfo<void> {
  const UnboardingRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnboardingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.UnboardingScreen();
    },
  );
}

/// generated route for
/// [_i14.UncomingEventsScreen]
class UncomingEventsRoute extends _i15.PageRouteInfo<void> {
  const UncomingEventsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UncomingEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UncomingEventsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.UncomingEventsScreen();
    },
  );
}
