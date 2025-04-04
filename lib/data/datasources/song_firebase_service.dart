import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/data/models/song.dart';
import 'package:music_app/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getAllSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getAllSongs() async {
    List<SongEntity> songs = [];

    try {
      var data = await FirebaseFirestore.instance.collection("Songs").get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(
          SongEntity(
            songModel.title ?? "",
            songModel.artist ?? "",
            songModel.duration ?? "",
            songModel.image ?? "",
          ),
        );
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }
}
