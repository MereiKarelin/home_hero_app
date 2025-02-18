import 'package:homehero/data/models/user_info_model.dart';

import 'package:homehero/domain/repo/user_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';

import 'package:injectable/injectable.dart';

class GetUserUseCaseParams {
  final String id;
  GetUserUseCaseParams({required this.id});
}

@lazySingleton
class GetUserUseCase implements UseCase<UserInfoModel, GetUserUseCaseParams> {
  final UserRepo repository;

  const GetUserUseCase({
    required this.repository,
  });

  @override
  Future<UserInfoModel> call(GetUserUseCaseParams params) async {
    return await repository.getUserInfo(params.id);
  }
}
