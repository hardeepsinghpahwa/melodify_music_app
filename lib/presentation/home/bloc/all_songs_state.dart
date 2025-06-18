part of 'all_songs_bloc.dart';

@immutable
class AllSongsState {
  final List<SongEntity>? allSongs;
  final List<SongEntity>? topSongs;
  final List<Playlist>? publicPlaylists;
  final bool loading;
  final bool dialogLoading;
  final String error;
  final String msg;

  const AllSongsState({
    this.allSongs,
    this.topSongs,
    this.publicPlaylists,
    this.loading = false,
    this.dialogLoading = false,
    this.error = "",
    this.msg = "",
  });

  AllSongsState copyWith({
    List<SongEntity>? allSongs,
    List<SongEntity>? topSongs,
    List<Playlist>? publicPlaylists,
    bool? loading,
    bool? dialogLoading,
    String? error,
    String? msg,
  }) {
    return AllSongsState(
      allSongs: allSongs ?? this.allSongs,
      publicPlaylists: publicPlaylists ?? this.publicPlaylists,
      topSongs: topSongs ?? this.topSongs,
      loading: loading ?? this.loading,
      dialogLoading: dialogLoading ?? this.dialogLoading,
      error: error ?? this.error,
      msg: msg ?? this.msg,
    );
  }
}
