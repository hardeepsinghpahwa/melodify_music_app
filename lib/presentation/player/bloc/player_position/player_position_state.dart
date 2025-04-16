part of 'player_position_bloc.dart';

@immutable
class PlayerCurrentState {
  final bool isPlaying;
  final double duration;
  final double position;
  final bool favourite;
  final SongEntity? currentSong;
  final String? error;
  final String? success;
  final bool loading;
  final List<SongEntity>? songs;
  final int currentIndex;

  const PlayerCurrentState({
    this.isPlaying = false,
    this.duration = 0,
    this.position = 0,
    this.favourite = false,
    this.currentSong,
    this.error,
    this.success,
    this.loading=false,
    this.songs,
    this.currentIndex=-1
  });

  PlayerCurrentState copyWith({
    bool? isPlaying,
    double? duration,
    double? position,
    bool? favourite,
    SongEntity? currentSong,
    String? error,
    String? success,
    bool? loading,
    List<SongEntity>? songs,
    int? currentIndex
  }) {
    return PlayerCurrentState(
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      favourite: favourite ?? this.favourite,
      currentSong: currentSong ?? this.currentSong,
      error: error ?? this.error,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      songs: songs ?? this.songs,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
