// lib/domain/use_case/assign_leader_use_case.dart

import 'package:homehero/domain/repo/event_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class AssignLeaderParams {
  final int eventId;
  final int leaderId;

  AssignLeaderParams({
    required this.eventId,
    required this.leaderId,
  });
}

@lazySingleton
class AssignLeaderUseCase implements UseCase<void, AssignLeaderParams> {
  final EventRepo repository;

  const AssignLeaderUseCase({
    required this.repository,
  });

  @override
  Future<void> call(AssignLeaderParams params) {
    return repository.assignLeader(params.eventId, params.leaderId);
  }
}
