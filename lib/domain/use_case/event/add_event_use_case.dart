import 'package:datex/data/models/event_model.dart';
import 'package:datex/domain/repo/event_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class AddEventUseCaseParams {
  final EventModel eventModel;
  AddEventUseCaseParams({required this.eventModel});
}

@lazySingleton
class AddEventUseCase implements UseCase<void, AddEventUseCaseParams> {
  final EventRepo repository;

  const AddEventUseCase({
    required this.repository,
  });

  @override
  Future<void> call(AddEventUseCaseParams params) {
    return repository.addEvent(params.eventModel);
  }
}
