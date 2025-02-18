import 'package:homehero/data/models/user_info_model.dart';

import 'package:homehero/domain/repo/user_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class UpdateUserUseCaseParams {
  final UserInfoModel userInfoModel;
  UpdateUserUseCaseParams({required this.userInfoModel});
}

@lazySingleton
class UpdateUserUseCase implements UseCase<void, UpdateUserUseCaseParams> {
  final UserRepo repository;

  const UpdateUserUseCase({
    required this.repository,
  });

  @override
  Future<void> call(UpdateUserUseCaseParams params) async {
    return await repository.updateUser(params.userInfoModel);
  }
}
