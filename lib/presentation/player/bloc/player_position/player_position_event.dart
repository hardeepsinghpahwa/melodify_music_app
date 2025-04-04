part of 'player_position_bloc.dart';

@immutable
sealed class PlayerPositionEvent {}

class PlayerPositionChangeEvent extends PlayerPositionEvent {
  final double index;

  PlayerPositionChangeEvent(this.index);
}

class PlayerDurationChangeEvent extends PlayerPositionEvent {
  final double duration;

  PlayerDurationChangeEvent(this.duration);
}
