import 'package:datex/data/models/user_info_model.dart';

import 'package:datex/data/source/user_remote_date_source.dart';

import 'package:datex/domain/repo/user_repo.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepo)
class UserRepoImpl implements UserRepo {
  final UserDataSource userDataSource;

  const UserRepoImpl({
    required this.userDataSource,
  });

  @override
  Future<void> createFollowing(UserInfoModel userInfoModel) async => await userDataSource.createFollowing(userInfoModel);
  @override
  Future<List<UserInfoModel>> getFollowers() async => await userDataSource.getFollowers();

  @override
  Future<UserInfoModel> getUserInfo(String id) async => await userDataSource.getUserInfo(id);

  @override
  Future<void> updateUser(UserInfoModel userInfoModel) async => await userDataSource.updateUser(userInfoModel);

  @override
  Future<void> setFirebaseToken(String token) async => await userDataSource.setFirebaseToken(token);
}
