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
import '../../data/source/auth_remote_data_source.dart' as _i904;
import '../../data/source/event_remote_data_source.dart' as _i61;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/repo/event_repo.dart' as _i374;
import '../../domain/use_casee/auth/check_number_use_case.dart' as _i79;
import '../../domain/use_casee/auth/confirm_code_use_case.dart' as _i224;
import '../../domain/use_casee/auth/login_use_case.dart' as _i792;
import '../../domain/use_casee/auth/register_use_case.dart' as _i28;
import '../../domain/use_casee/event/get_events_use_case.dart' as _i973;
import '../../features/auth/bloc/auth_bloc.dart' as _i55;
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
    gh.lazySingleton<_i904.AuthDataSource>(() => _i904.AuthDataSourceImpl(
          gh<_i894.DioClient>(),
          gh<_i867.SharedDb>(),
        ));
    gh.lazySingleton<_i61.EventDataSource>(() => _i61.EventDataSourceImpl(
          gh<_i894.DioClient>(),
          gh<_i867.SharedDb>(),
        ));
    gh.lazySingleton<_i716.AuthRepo>(
        () => _i540.AuthRepoImpl(authDataSource: gh<_i904.AuthDataSource>()));
    gh.lazySingleton<_i224.ConfirmCodeUseCase>(
        () => _i224.ConfirmCodeUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i28.RegistrationUseCase>(
        () => _i28.RegistrationUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i792.LoginUseCase>(
        () => _i792.LoginUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i79.CheckNumberUseCase>(
        () => _i79.CheckNumberUseCase(repository: gh<_i716.AuthRepo>()));
    gh.lazySingleton<_i374.EventRepo>(
        () => _i212.EventRepoImpl(eventDataSource: gh<_i61.EventDataSource>()));
    gh.lazySingleton<_i973.GetEventsUseCase>(
        () => _i973.GetEventsUseCase(repository: gh<_i374.EventRepo>()));
    gh.factory<_i55.AuthBloc>(() => _i55.AuthBloc(
          gh<_i792.LoginUseCase>(),
          gh<_i28.RegistrationUseCase>(),
          gh<_i224.ConfirmCodeUseCase>(),
          gh<_i79.CheckNumberUseCase>(),
        ));
    gh.factory<_i299.MainBloc>(
        () => _i299.MainBloc(gh<_i973.GetEventsUseCase>()));
    return this;
  }
}
