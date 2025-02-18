import 'package:homehero/features/auth/bloc/auth_bloc.dart';
import 'package:homehero/features/event/bloc/event_bloc.dart';
import 'package:homehero/features/following/bloc/following_bloc.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/features/notification/bloc/notifications_bloc.dart';
import 'package:homehero/utils/injectable/configurator.dart';

class BlocUtils {
  static final authBloc = getIt.get<AuthBloc>();
  static final mainBloc = getIt.get<MainBloc>();
  static final eventBloc = getIt.get<EventBloc>();
  static final follofingBloc = getIt.get<FollowingBloc>();
  static final notificationsBloc = getIt.get<NotificationsBloc>();
}

enum Status { success, loading, error }
