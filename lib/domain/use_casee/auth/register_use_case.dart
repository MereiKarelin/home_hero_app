import 'package:datex/domain/repo/auth_repo.dart';
import 'package:datex/domain/use_casee/base_use_case.dart';
import 'package:injectable/injectable.dart';

class RegistrationUseCaseParams {
  final String number;
  final String name;
  RegistrationUseCaseParams({required this.number, required this.name});
}

@lazySingleton
class RegistrationUseCase implements UseCase<void, RegistrationUseCaseParams> {
  final AuthRepo repository;

  const RegistrationUseCase({
    required this.repository,
  });

  @override
  Future<void> call(RegistrationUseCaseParams params) async {
    return await repository.registration(params.number, params.name);
  }
}
