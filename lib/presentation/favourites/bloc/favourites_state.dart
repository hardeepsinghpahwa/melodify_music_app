part of 'favourites_bloc.dart';

@immutable
class FavouritesState {
  final List<SongEntity>? songFavourites;
  final bool? isLoading;

  const FavouritesState({this.songFavourites, this.isLoading});

  FavouritesState copyWith({
    List<SongEntity>? songFavourites,
    bool? isLoading,
  }) {
    return FavouritesState(
      songFavourites: songFavourites ?? this.songFavourites,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
