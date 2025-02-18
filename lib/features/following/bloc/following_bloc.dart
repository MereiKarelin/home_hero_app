import 'package:bloc/bloc.dart';
import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:homehero/domain/use_case/user/create_following_use_case.dart';
import 'package:homehero/domain/use_case/user/get_followers_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'following_event.dart';
part 'following_state.dart';

@Injectable()
class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  final CreateFollowingUseCase createFollowingUseCase;
  final GetFollowersUseCase getFollowersUseCase;
  FollowingBloc(this.createFollowingUseCase, this.getFollowersUseCase) : super(FollowingInitial()) {
    on<FollowingEvent>((event, emit) {
      on<CreateFollowerEvent>(_createFollowing);
      on<GetFollowersEvent>(_getFollowers);
    });
  }
  Future<void> _createFollowing(CreateFollowerEvent event, Emitter<FollowingState> emit) async {
    try {
      await createFollowingUseCase(CreateFollowingUseCaseParams(userInfoModel: event.userInfoModel));
      emit(FollowerCreatedState());
      final followers = await getFollowersUseCase(NoParams());

      emit(FollowersLoadedState(followers: followers));
    } catch (e) {
      emit(FollowingErrorState(error: e.toString()));
    }
  }

  Future<void> _getFollowers(GetFollowersEvent event, Emitter<FollowingState> emit) async {
    try {
      final followers = await getFollowersUseCase(NoParams());

      emit(FollowersLoadedState(followers: followers));
    } catch (e) {
      emit(FollowingErrorState(error: e.toString()));
    }
  }
}
