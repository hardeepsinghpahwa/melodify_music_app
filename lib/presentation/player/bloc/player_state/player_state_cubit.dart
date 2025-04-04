import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_state_state.dart';

class PlayerStateCubit extends Cubit<PlayerStateState> {
  PlayerStateCubit() : super(PlayerStateStopped());

  play() {
    emit(PlayerStatePlaying());
  }

  pause() {
    emit(PlayerStateStopped());
  }
}
