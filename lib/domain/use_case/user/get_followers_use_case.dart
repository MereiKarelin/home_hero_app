import 'package:datex/data/models/user_info_model.dart';

import 'package:datex/domain/repo/user_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFollowersUseCase implements UseCase<List<UserInfoModel>, NoParams> {
  final UserRepo repository;

  const GetFollowersUseCase({
    required this.repository,
  });

  @override
  Future<List<UserInfoModel>> call(NoParams params) async {
    return await repository.getFollowers();
  }
}
