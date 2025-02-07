import 'package:datex/data/models/user_info_model.dart';

import 'package:datex/domain/repo/user_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class CreateFollowingUseCaseParams {
  final UserInfoModel userInfoModel;
  CreateFollowingUseCaseParams({required this.userInfoModel});
}

@lazySingleton
class CreateFollowingUseCase implements UseCase<void, CreateFollowingUseCaseParams> {
  final UserRepo repository;

  const CreateFollowingUseCase({
    required this.repository,
  });

  @override
  Future<void> call(CreateFollowingUseCaseParams params) async {
    return await repository.createFollowing(params.userInfoModel);
  }
}
