part of 'all_songs_bloc.dart';

@immutable
sealed class SongsEvent {}

class AllSongsLoadingEvent extends SongsEvent {}

class Top10SongsLoadingEvent extends SongsEvent {}

class PublicPlaylistsEvent extends SongsEvent {}

class MyPlaylistsEvent extends SongsEvent {}

class UpdateMyPlaylistsEvent extends SongsEvent {
  final List<Playlist> playlists;

  UpdateMyPlaylistsEvent(this.playlists);
}

class CreateNewPlaylistEvent extends SongsEvent {
  final String name;

  CreateNewPlaylistEvent(this.name);
}

class AddSongToPlaylistEvent extends SongsEvent {
  final String playlistId;
  final String songId;
  final bool add;

  AddSongToPlaylistEvent(this.playlistId, this.songId, this.add);
}
