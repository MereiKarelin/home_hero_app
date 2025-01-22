import 'package:bloc/bloc.dart';
import 'package:datex/data/models/event_model.dart';
import 'package:datex/domain/use_case/event/add_event_use_case.dart';
import 'package:datex/domain/use_case/event/update_event_use_case.dart';
import 'package:datex/features/main/bloc/main_bloc.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'event_event.dart';
part 'event_state.dart';

@Injectable()
class EventBloc extends Bloc<EventEvent, EventState> {
  final AddEventUseCase addEventUseCase;
  final UpdateEventUseCase updateEventUseCase;
  EventBloc(this.addEventUseCase, this.updateEventUseCase) : super(EventInitial()) {
    on<UpdateEvEvent>(_updateEv);
    on<AddEvEvent>(_addEv);
  }

  Future<void> _addEv(AddEvEvent event, Emitter<EventState> emit) async {
    await addEventUseCase(AddEventUseCaseParams(eventModel: event.eventModel));
    BlocUtils.mainBloc.add(MainStartEvent());
  }

  Future<void> _updateEv(UpdateEvEvent event, Emitter<EventState> emit) async {
    await updateEventUseCase(UpdateEventUseCaseParams(event.eventModel.id.toString(), eventModel: event.eventModel));
    BlocUtils.mainBloc.add(MainStartEvent());
  }
}
