part of 'explore_bloc.dart';

@immutable
class ExploreState {

  final List<SongEntity>? filteredSongs;
  final bool loading;
  final String error;

  const ExploreState({this.filteredSongs, this.loading = false,this.error=""});

  ExploreState copyWith({
    List<SongEntity>? filteredSongs,
    bool? loading,
    String? error,
  }) {
    return ExploreState(
      filteredSongs: filteredSongs ?? this.filteredSongs,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}