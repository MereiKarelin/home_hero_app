import 'package:datex/domain/repo/auth_repo.dart';
import 'package:datex/domain/use_casee/base_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginUseCaseParams {
  final String number;
  LoginUseCaseParams({
    required this.number,
  });
}

@lazySingleton
class LoginUseCase implements UseCase<void, LoginUseCaseParams> {
  final AuthRepo repository;

  const LoginUseCase({
    required this.repository,
  });

  @override
  Future<void> call(LoginUseCaseParams params) async {
    return await repository.login(
      params.number,
    );
  }
}
