import 'package:dartz/dartz.dart';
import 'package:music_app/data/datasources/song_firebase_service.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../domain/entities/song/playlist.dart';
import '../../services.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getAllSongs() {
    return sl<SongFirebaseService>().getAllSongs();
  }

  @override
  Future<Either> favouriteSong(bool fav, String songId) {
    return sl<SongFirebaseService>().favouriteSong(fav, songId);
  }

  @override
  Future<Either> isFavourite(String songId) {
    return sl<SongFirebaseService>().isFavourite(songId);
  }

  @override
  Future<Either> getAllFavouriteSongs() {
    return sl<SongFirebaseService>().getAllFavouriteSongs();
  }

  @override
  Future<Either> getTopSongs() {
    return sl<SongFirebaseService>().getTopSongs();
  }

  @override
  Future<Either> searchSong(String searchText) {
    return sl<SongFirebaseService>().searchSong(searchText);
  }

  @override
  Future<Either> getPublicPlaylists() {
    return sl<SongFirebaseService>().getPublicPlaylists();
  }

  @override
  Future<Either> getPlaylistSongs(String playlistId) {
    return sl<SongFirebaseService>().getPlaylistSongs(playlistId);
  }

  @override
  Future<Either> createNewPlaylist(String name) {
    return sl<SongFirebaseService>().createNewPlaylist(name);
  }

  @override
  Stream<List<Playlist>> getMyPlaylists() {
    return sl<SongFirebaseService>().getMyPlaylists();
  }

  @override
  Future<Either> addSongToPlaylist(String playlistId, String songID,bool add) {
    return sl<SongFirebaseService>().addSongToPlaylist(playlistId,songID,add);
  }
}
