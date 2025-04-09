part of 'all_songs_bloc.dart';

@immutable
class AllSongsState {
  final List<SongEntity>? allSongs;
  final List<SongEntity>? topSongs;
  final bool loading;
  final String error;

  const AllSongsState({this.allSongs, this.topSongs, this.loading = false,this.error=""});

  AllSongsState copyWith({
    List<SongEntity>? allSongs,
    List<SongEntity>? topSongs,
    bool? loading,
    String? error,
  }) {
    return AllSongsState(
      allSongs: allSongs ?? this.allSongs,
      topSongs: topSongs ?? this.topSongs,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
