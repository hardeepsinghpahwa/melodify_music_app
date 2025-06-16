part of 'playlist_details_bloc.dart';

@immutable
sealed class PlaylistDetailsEvent {}

class LoadPlaylistSongs extends PlaylistDetailsEvent{
  final String playlistId;

  LoadPlaylistSongs(this.playlistId);
}
