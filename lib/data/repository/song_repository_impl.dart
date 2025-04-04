import 'package:dartz/dartz.dart';
import 'package:music_app/data/datasources/song_firebase_service.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getAllSongs() {
    return sl<SongFirebaseService>().getAllSongs();
  }
}