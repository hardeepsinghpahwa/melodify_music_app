import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/data/models/song.dart';
import 'package:music_app/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getAllSongs();

  Future<Either> getAllFavouriteSongs();

  Future<Either> getTopSongs();

  Future<Either> favouriteSong(bool fav, String songId);

  Future<Either> isFavourite(String songId);

  Future<Either> searchSong(String searchText);
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
            songModel.link ?? "",
            element.id,
          ),
        );
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> favouriteSong(bool fav, String songId) async {
    try {
      if (fav) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("Favourites")
            .doc(songId)
            .set({"favourite": "true"});
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("Favourites")
            .doc(songId)
            .delete();
      }
      return Right("Success");
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> isFavourite(String songId) async {
    try {
      var snap =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("Favourites")
              .doc(songId)
              .get();

      if (snap.exists) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> getAllFavouriteSongs() async {
    List<SongEntity> songs = [];

    try {
      var favIds =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Favourites")
              .get();

      List<String> ids = [];
      for (var i in favIds.docs) {
        ids.add(i.id);
      }

      var data =
          await FirebaseFirestore.instance
              .collection("Songs")
              .where(FieldPath.documentId, whereIn: ids)
              .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(
          SongEntity(
            songModel.title ?? "",
            songModel.artist ?? "",
            songModel.duration ?? "",
            songModel.image ?? "",
            songModel.link ?? "",
            element.id,
          ),
        );
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> getTopSongs() async {
    List<SongEntity> songs = [];

    try {
      var topIds =
          await FirebaseFirestore.instance
              .collection("Top10")
              .orderBy('priority', descending: false)
              .get();

      List<String> ids = [];
      for (var i in topIds.docs) {
        ids.add(i['songId']);
      }

      var data =
          await FirebaseFirestore.instance
              .collection("Songs")
              .where(FieldPath.documentId, whereIn: ids)
              .get();

      var newItems = data.docs;
      newItems.sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));

      for (var element in newItems) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(
          SongEntity(
            songModel.title ?? "",
            songModel.artist ?? "",
            songModel.duration ?? "",
            songModel.image ?? "",
            songModel.link ?? "",
            element.id,
          ),
        );
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> searchSong(String searchText) async {
    List<SongEntity> songs = [];
    try {
      final titleResults =
          FirebaseFirestore.instance
              .collection("Songs")
              .where('artist', isGreaterThanOrEqualTo: searchText)
              .where('artist', isLessThanOrEqualTo: '$searchText\uf8ff')
              .get();

      final artistResults =
          FirebaseFirestore.instance
              .collection("Songs")
              .where('title', isGreaterThanOrEqualTo: searchText)
              .where('title', isLessThanOrEqualTo: '$searchText\uf8ff')
              .get();

      final allResults = await Future.wait([titleResults, artistResults]);

      final allDocs = {...allResults[0].docs, ...allResults[1].docs}.toList();

      for (var element in allDocs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(
          SongEntity(
            songModel.title ?? "",
            songModel.artist ?? "",
            songModel.duration ?? "",
            songModel.image ?? "",
            songModel.link ?? "",
            element.id,
          ),
        );
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      return Left("Something went wrong");
    }
  }
}
