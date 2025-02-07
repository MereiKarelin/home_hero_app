import 'package:datex/data/models/event_model.dart';
import 'package:datex/domain/repo/event_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class UpdateEventUseCaseParams {
  final String id;
  final EventModel eventModel;
  UpdateEventUseCaseParams(this.id, {required this.eventModel});
}

@lazySingleton
class UpdateEventUseCase implements UseCase<void, UpdateEventUseCaseParams> {
  final EventRepo repository;

  const UpdateEventUseCase({required this.repository});

  @override
  Future<void> call(UpdateEventUseCaseParams params) {
    return repository.updateEvent(params.id, params.eventModel);
  }
}
