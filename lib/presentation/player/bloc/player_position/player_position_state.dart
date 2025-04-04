part of 'player_position_bloc.dart';

@immutable
sealed class PlayerPositionState {}

class PlayerPositionChangeState extends PlayerPositionState {
  final double currentIndex;

  PlayerPositionChangeState(this.currentIndex);
}

class PlayerDurationChangeState extends PlayerPositionState {
  final double duration;

  PlayerDurationChangeState(this.duration);
}
