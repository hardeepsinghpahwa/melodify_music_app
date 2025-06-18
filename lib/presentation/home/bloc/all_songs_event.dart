part of 'all_songs_bloc.dart';

@immutable
sealed class SongsEvent {}

class AllSongsLoadingEvent extends SongsEvent {}

class Top10SongsLoadingEvent extends SongsEvent {}

class PublicPlaylistsEvent extends SongsEvent {}

class MyPlaylistsEvent extends SongsEvent {}

class CreateNewPlaylistEvent extends SongsEvent {

  final String name;

  CreateNewPlaylistEvent(this.name);
}
