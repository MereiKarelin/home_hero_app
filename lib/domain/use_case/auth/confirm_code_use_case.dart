import 'package:homehero/domain/repo/auth_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:homehero/features/core/auth_utils.dart';
import 'package:injectable/injectable.dart';

class ConfirmCodeUseCaseParams {
  final String number;
  final String code;
  final AuthType authType;
  ConfirmCodeUseCaseParams({
    required this.number,
    required this.code,
    required this.authType,
  });
}

@lazySingleton
class ConfirmCodeUseCase implements UseCase<void, ConfirmCodeUseCaseParams> {
  final AuthRepo repository;

  const ConfirmCodeUseCase({
    required this.repository,
  });

  @override
  Future<void> call(ConfirmCodeUseCaseParams params) async {
    return await repository.confirmCode(params.number, params.code, params.authType);
  }
}
