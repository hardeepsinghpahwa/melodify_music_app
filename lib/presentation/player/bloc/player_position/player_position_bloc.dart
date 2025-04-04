import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_position_event.dart';

part 'player_position_state.dart';

class PlayerPositionBloc
    extends Bloc<PlayerPositionEvent, PlayerPositionState> {
  PlayerPositionBloc() : super(PlayerPositionChangeState(0)) {
    on<PlayerPositionChangeEvent>((event, emit) {
      emit(PlayerPositionChangeState(event.index));
    });

    on<PlayerDurationChangeEvent>((event, emit) {
      emit(PlayerDurationChangeState(event.duration));
    });
  }
}
