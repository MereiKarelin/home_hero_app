import 'package:homehero/data/source/auth_remote_data_source.dart';
import 'package:homehero/domain/repo/auth_repo.dart';
import 'package:homehero/features/core/auth_utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  const AuthRepoImpl({
    required this.authDataSource,
  });

  @override
  Future<bool> checkNumber(String number) async => await authDataSource.checkNumber(number);

  @override
  Future<void> confirmCode(String number, String code, AuthType authType) async => await authDataSource.confirmCode(number, code, authType);

  @override
  Future<void> login(
    String number,
  ) async =>
      await authDataSource.login(
        number,
      );

  @override
  Future<void> registration(String number, String name, String userType) async => await authDataSource.registration(number, name, userType);
}
