import 'package:dartz/dartz.dart';

abstract class SongRepository{

  Future<Either> getAllSongs();
  Future<Either> favouriteSong(bool fav,String songId);
  Future<Either> isFavourite(String songId);
  Future<Either> getAllFavouriteSongs();
  Future<Either> getTopSongs();
  Future<Either> searchSong(String searchText);
  Future<Either> getPublicPlaylists();
  Future<Either> getPlaylistSongs(String playlistId);
  Future<Either> createNewPlaylist(String name);

}