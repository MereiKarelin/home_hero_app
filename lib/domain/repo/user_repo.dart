import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/domain/use_case/user/set_firebase_token_use_case.dart';

abstract class UserRepo {
  Future<void> createFollowing(UserInfoModel following);
  Future<void> updateUser(UserInfoModel following);
  Future<void> setFirebaseToken(String firebaseToken);
  Future<List<UserInfoModel>> getFollowers();
  Future<UserInfoModel> getUserInfo(String id);
}
