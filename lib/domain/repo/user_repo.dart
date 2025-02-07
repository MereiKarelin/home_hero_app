import 'package:datex/data/models/user_info_model.dart';

abstract class UserRepo {
  Future<void> createFollowing(UserInfoModel following);
  Future<void> updateUser(UserInfoModel following);
  Future<List<UserInfoModel>> getFollowers();
  Future<UserInfoModel> getUserInfo(String id);
}
