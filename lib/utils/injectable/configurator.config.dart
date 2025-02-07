// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../data/repo_impl/event_repo_impl.dart' as _i212;
import '../../data/repo_impl/user_repo_impl.dart' as _i89;
import '../../data/source/auth_remote_data_source.dart' as _i904;
import '../../data/source/event_remote_data_source.dart' as _i61;
import '../../data/source/user_remote_date_source.dart' as _i193;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/repo/event_repo.dart' as _i374;
import '../../domain/repo/user_repo.dart' as _i998;
import '../../domain/use_case/auth/check_number_use_case.dart' as _i116;
import '../../domain/use_case/auth/confirm_code_use_case.dart' as _i152;
import '../../domain/use_case/auth/login_use_case.dart' as _i408;
import '../../domain/use_case/auth/register_use_case.dart' as _i1020;
import '../../domain/use_case/event/add_event_use_case.dart' as _i187;
import '../../domain/use_case/event/get_events_by_day_use_case.dart' as _i608;
import '../../domain/use_case/event/get_events_by_mounth_use_case.dart'
    as _i595;
import '../../domain/use_case/event/update_event_use_case.dart' as _i1002;
import '../../domain/use_case/user/create_following_use_case.dart' as _i1002;
import '../../domain/use_case/user/get_followers_use_case.dart' as _i448;
import '../../domain/use_case/user/get_user_info_use_case.dart' as _i635;
import '../../domain/use_case/user/update_user_use_case.dart' as _i189;
import '../../features/auth/bloc/auth_bloc.dart' as _i55;
import '../../features/event/bloc/event_bloc.dart' as _i99;
import '../../features/following/bloc/following_bloc.dart' as _i306;
import '../../features/main/bloc/main_bloc.dart' as _i299;
import '../dio_client.dart' as _i894;
import '../shared_db.dart' as _i867;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i867.SharedDb>(() => _i867.SharedDb());
    gh.lazySingleton<_i894.DioClient>(
        () => _i894.DioClient(gh<_i867.SharedDb>()));
    gh.lazySingleton<_i193.UserDataSource>(() => _i193.UserDataSourceImpl(
          gh<_i894.DioClient>(),
          gh<_i867.SharedDb>(),
        ));
    gh.lazySingleton<_i904.AuthDataSource>(() => _i904.AuthDataSourceImpl(
          gh<_i894.DioClient>(),
          gh<_i867.SharedDb>(),
        ));
    gh.lazySingleton<_i61.EventDataSource>(() => _i61.EventDataSourceImpl(
          gh<_i894.DioClient>(),
          gh<_i867.SharedDb>(),
        ));
    gh.lazySingleton<_i998.UserRepo>(
        () => _i89.UserRepoImpl(userDataSource: gh<_i193.UserDataSource>()));
    gh.lazySingleton<_i635.GetUserUseCase>(
        () => _i635.GetUserUseCase(repository: gh<_i998.UserRepo>()));
    gh.lazySingleton<_i1002.CreateFollowingUseCase>(
        () => _i1002.CreateFollowingUseCase(repository: gh<_i998.UserRepo>()));
    gh.lazySingleton<_i189.UpdateUserUseCase>(
        () => _i189.UpdateUserUseCase(repository: gh<_i998.UserRepo>()));
    gh.lazySingleton<_i448.GetFollowersUseCase>(
        () => _i448.GetFollowersUseCase(repository: gh<_i998.UserRepo>()));
    gh.lazySingleton<_i716.AuthRepo>(
        () => _i540.AuthRepoImpl(authDataSource: gh<_i904.AuthDataSource>()));
    gh.lazySingleton<_i152.ConfirmCodeUseCase>(
        () => _i152.ConfirmCodeUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i1020.RegistrationUseCase>(
        () => _i1020.RegistrationUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i408.LoginUseCase>(
        () => _i408.LoginUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i116.CheckNumberUseCase>(
        () => _i116.CheckNumberUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i374.EventRepo>(
        () => _i212.EventRepoImpl(eventDataSource: gh<_i61.EventDataSource>()));
    gh.factory<_i306.FollowingBloc>(() => _i306.FollowingBloc(
          gh<_i1002.CreateFollowingUseCase>(),
          gh<_i448.GetFollowersUseCase>(),
        ));
    gh.lazySingleton<_i595.GetEventsByMonthUseCase>(
        () => _i595.GetEventsByMonthUseCase(repository: gh<_i374.EventRepo>()));
    gh.lazySingleton<_i608.GetEventsByDayUseCase>(
        () => _i608.GetEventsByDayUseCase(repository: gh<_i374.EventRepo>()));
    gh.lazySingleton<_i187.AddEventUseCase>(
        () => _i187.AddEventUseCase(repository: gh<_i374.EventRepo>()));
    gh.lazySingleton<_i1002.UpdateEventUseCase>(
        () => _i1002.UpdateEventUseCase(repository: gh<_i374.EventRepo>()));
    gh.factory<_i55.AuthBloc>(() => _i55.AuthBloc(
          gh<_i408.LoginUseCase>(),
          gh<_i1020.RegistrationUseCase>(),
          gh<_i152.ConfirmCodeUseCase>(),
          gh<_i116.CheckNumberUseCase>(),
        ));
    gh.factory<_i299.MainBloc>(() => _i299.MainBloc(
          gh<_i595.GetEventsByMonthUseCase>(),
          gh<_i448.GetFollowersUseCase>(),
          gh<_i635.GetUserUseCase>(),
          gh<_i189.UpdateUserUseCase>(),
        ));
    gh.factory<_i99.EventBloc>(() => _i99.EventBloc(
          gh<_i187.AddEventUseCase>(),
          gh<_i1002.UpdateEventUseCase>(),
        ));
    return this;
  }
}
