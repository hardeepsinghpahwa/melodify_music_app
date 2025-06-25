part of 'explore_bloc.dart';

@immutable
class ExploreState {

  final List<SongEntity>? filteredSongs;
  final List<String>? recentSearches;
  final bool loading;
  final bool searchFocus;
  final String error;

  const ExploreState({this.searchFocus=false,  this.recentSearches,this.filteredSongs, this.loading = false,this.error=""});

  ExploreState copyWith({
    List<SongEntity>? filteredSongs,
    List<String>? recentSearches,
    bool? loading,
    bool? searchFocus,
    String? error,
  }) {
    return ExploreState(
      filteredSongs: filteredSongs ?? this.filteredSongs,
      recentSearches: recentSearches ?? this.recentSearches,
      loading: loading ?? this.loading,
      searchFocus: searchFocus ?? this.searchFocus,
      error: error ?? this.error,
    );
  }
}