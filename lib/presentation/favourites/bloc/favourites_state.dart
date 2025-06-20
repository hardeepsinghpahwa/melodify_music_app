part of 'favourites_bloc.dart';

@immutable
class FavouritesState {
  final List<SongEntity>? songFavourites;
  final List<Playlist>? myPlaylists;
  final bool? isLoading;
  final bool dialogLoading;
  final bool backPress;
  final String error;
  final String msg;

  const FavouritesState({
    this.myPlaylists,
    this.songFavourites,
    this.isLoading,
    this.dialogLoading=false,
    this.backPress=false,
    this.error = "",
    this.msg = "",
  });

  FavouritesState copyWith({
    List<SongEntity>? songFavourites,
    List<Playlist>? myPlaylists,
    bool? isLoading,
    bool? dialogLoading,
    bool? backPress,
    String? error,
    String? msg,
  }) {
    return FavouritesState(
      songFavourites: songFavourites ?? this.songFavourites,
      myPlaylists: myPlaylists ?? this.myPlaylists,
      isLoading: isLoading ?? this.isLoading,
      backPress: backPress ?? this.backPress,
      error: error ?? this.error,
      dialogLoading: dialogLoading ?? this.dialogLoading,
      msg: msg ?? this.msg,
    );
  }
}
