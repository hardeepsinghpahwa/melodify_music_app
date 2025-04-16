part of 'player_position_bloc.dart';

@immutable
sealed class PlayerEvent {}

class PlayerPositionChangeEvent extends PlayerEvent {
  final double position;

  PlayerPositionChangeEvent(this.position);
}

class PlayerDurationChangeEvent extends PlayerEvent {
  final double duration;

  PlayerDurationChangeEvent(this.duration);
}

class PlayerPlayChangeEvent extends PlayerEvent {
  final bool playing;

  PlayerPlayChangeEvent(this.playing);
}

class ChangeSongEvent extends PlayerEvent {
  final List<SongEntity> songs;
  final currentIndex;

  ChangeSongEvent(this.songs,this.currentIndex);
}

class FavouriteEvent extends PlayerEvent {
  final bool favourite;
  final String songId;

  FavouriteEvent(this.favourite, this.songId);
}

class ErrorEvent extends PlayerEvent {
  final String error;

  ErrorEvent(this.error);
}


class CheckFavouriteEvent extends PlayerEvent {
  final String songId;

  CheckFavouriteEvent(this.songId);
}


