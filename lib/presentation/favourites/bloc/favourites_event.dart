part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class MarkFavouriteEvent extends FavouritesEvent {
  final List<SongEntity>? songFav;
  final bool? isLoading;

  MarkFavouriteEvent({this.songFav, this.isLoading = false});
}

class GetAllFavouritesEvent extends FavouritesEvent {
}

class CreateNewPlaylistEvent extends FavouritesEvent {
  final String name;

  CreateNewPlaylistEvent(this.name);
}


class GetMyPlaylistsEvent extends FavouritesEvent {
}

class ResetEvents extends FavouritesEvent {
}

class UpdateMyPlaylistsEvent extends FavouritesEvent {
  final List<Playlist> playlists;

  UpdateMyPlaylistsEvent(this.playlists);
}