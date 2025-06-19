part of 'all_songs_bloc.dart';

@immutable
class AllSongsState {
  final List<SongEntity>? allSongs;
  final List<SongEntity>? topSongs;
  final List<Playlist>? publicPlaylists;
  final List<String>? playlistLoader;
  final bool loading;
  final bool dialogLoading;
  final bool backPress;
  final String error;
  final String msg;
  final List<Playlist>? myPlaylists;

  const AllSongsState({
    this.allSongs,
    this.topSongs,
    this.publicPlaylists,
    this.playlistLoader,
    this.myPlaylists,
    this.loading = false,
    this.backPress = false,
    this.dialogLoading = false,
    this.error = "",
    this.msg = "",
  });

  AllSongsState copyWith({
    List<SongEntity>? allSongs,
    List<SongEntity>? topSongs,
    List<Playlist>? publicPlaylists,
    List<Playlist>? myPlaylists,
    List<String>? playlistLoader,
    bool? loading,
    bool? backPress,
    bool? dialogLoading,
    String? error,
    String? msg,
  }) {
    return AllSongsState(
      allSongs: allSongs ?? this.allSongs,
      publicPlaylists: publicPlaylists ?? this.publicPlaylists,
      myPlaylists: myPlaylists ?? this.myPlaylists,
      playlistLoader: playlistLoader ?? this.playlistLoader,
      topSongs: topSongs ?? this.topSongs,
      loading: loading ?? this.loading,
      backPress: backPress ?? this.backPress,
      dialogLoading: dialogLoading ?? this.dialogLoading,
      error: error ?? this.error,
      msg: msg ?? this.msg,
    );
  }
}
