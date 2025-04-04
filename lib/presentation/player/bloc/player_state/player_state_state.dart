part of 'player_state_cubit.dart';

sealed class PlayerStateState extends Equatable {
  const PlayerStateState();
}

final class PlayerStateStopped extends PlayerStateState {
  @override
  List<Object> get props => [];
}

final class PlayerStatePlaying extends PlayerStateState {
  @override
  List<Object> get props => [];
}
