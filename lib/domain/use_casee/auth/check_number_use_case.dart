import 'package:datex/domain/repo/auth_repo.dart';
import 'package:datex/domain/use_casee/base_use_case.dart';
import 'package:injectable/injectable.dart';

class CheckNumberUseCaseParams {
  final String number;
  CheckNumberUseCaseParams({required this.number});
}

@lazySingleton
class CheckNumberUseCase implements UseCase<bool, CheckNumberUseCaseParams> {
  final AuthRepo repository;

  const CheckNumberUseCase({
    required this.repository,
  });

  @override
  Future<bool> call(CheckNumberUseCaseParams params) async {
    return await repository.checkNumber(params.number);
  }
}
