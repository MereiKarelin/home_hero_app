import 'package:homehero/data/models/user_info_model.dart';

import 'package:homehero/domain/repo/user_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class SetFirebaseTokenParams {
  final String token;

  SetFirebaseTokenParams({required this.token});
}

@lazySingleton
class SetFirebaseToken implements UseCase<void, SetFirebaseTokenParams> {
  final UserRepo repository;

  const SetFirebaseToken({
    required this.repository,
  });

  @override
  Future<void> call(SetFirebaseTokenParams params) async {
    return await repository.setFirebaseToken(params.token);
  }
}
