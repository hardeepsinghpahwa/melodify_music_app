import 'package:dartz/dartz.dart';

abstract class SongRepository{

  Future<Either> getAllSongs();
  Future<Either> favouriteSong(bool fav,String songId);
  Future<Either> isFavourite(String songId);
  Future<Either> getAllFavouriteSongs();
  Future<Either> getTopSongs();

}