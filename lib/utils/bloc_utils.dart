import 'package:datex/features/auth/bloc/auth_bloc.dart';
import 'package:datex/features/event/bloc/event_bloc.dart';
import 'package:datex/features/following/bloc/following_bloc.dart';
import 'package:datex/features/main/bloc/main_bloc.dart';
import 'package:datex/utils/injectable/configurator.dart';

class BlocUtils {
  static final authBloc = getIt.get<AuthBloc>();
  static final mainBloc = getIt.get<MainBloc>();
  static final eventBloc = getIt.get<EventBloc>();
  static final follofingBloc = getIt.get<FollowingBloc>();
}
