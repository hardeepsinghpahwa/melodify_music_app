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
