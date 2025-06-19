import 'package:dartz/dartz.dart';

import '../entities/song/playlist.dart';

abstract class SongRepository {
  Future<Either> getAllSongs();

  Future<Either> favouriteSong(bool fav, String songId);

  Future<Either> isFavourite(String songId);

  Future<Either> getAllFavouriteSongs();

  Future<Either> getTopSongs();

  Future<Either> searchSong(String searchText);

  Future<Either> getPublicPlaylists();

  Future<Either> getPlaylistSongs(String playlistId);

  Future<Either> createNewPlaylist(String name);

  Stream<List<Playlist>> getMyPlaylists();

  Future<Either> addSongToPlaylist(String playlistId, String songID,bool add);
}
