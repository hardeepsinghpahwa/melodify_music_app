part of 'playlist_details_bloc.dart';

class PlaylistDetailsState {
  final List<SongEntity>? songs;
  final bool? loading;
  final String? error;

  PlaylistDetailsState({this.loading = false, this.error = "", this.songs});

  PlaylistDetailsState copyWith({
    List<SongEntity>? songs,
    bool? loading,
    String? error,
  }) {
    return PlaylistDetailsState(
      songs: songs ?? this.songs,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
