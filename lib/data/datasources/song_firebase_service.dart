import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/data/models/playlistModel.dart';
import 'package:music_app/data/models/song.dart';
import 'package:music_app/domain/entities/song/addSong.dart';
import 'package:music_app/domain/entities/song/playlist.dart';
import 'package:music_app/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getAllSongs();

  Future<Either> getAllFavouriteSongs();

  Future<Either> getTopSongs();

  Future<Either> favouriteSong(bool fav, String songId);

  Future<Either> isFavourite(String songId);

  Future<Either> searchSong(String searchText);

  Future<Either> getPublicPlaylists();

  Stream<List<Playlist>> getMyPlaylists();

  Future<Either> getPlaylistSongs(String playlistId);

  Future<Either> createNewPlaylist(String name);

  Future<Either> addSongToPlaylist(String playlistId, String songID, bool add);
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

      if (ids.isEmpty) {
        return Right(songs);
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
  Future<Either> getPlaylistSongs(String playlistId) async {
    List<SongEntity> songs = [];

    print("PLAYLIST ID $playlistId");
    try {
      var playlistIds =
          await FirebaseFirestore.instance
              .collection("Playlists")
              .doc(playlistId)
              .collection("songs")
              .get();

      List<String> ids = [];
      for (var i in playlistIds.docs) {
        ids.add(i['songId']);
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
              .orderBy("artist")
              //.where('artist', isGreaterThanOrEqualTo: searchText)
              //.where('artist', isLessThanOrEqualTo: '$searchText\uf8ff')
              .startAt([searchText])
              .endAt(['$searchText\uf8ff'])
              .get();

      final artistResults =
          FirebaseFirestore.instance
              .collection("Songs")
              .orderBy("title")
              //.where('title', isGreaterThanOrEqualTo: searchText)
              //.where('title', isLessThanOrEqualTo: '$searchText\uf8ff')
              .startAt([searchText])
              .endAt(['$searchText\uf8ff'])
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
    } on Exception catch (e) {
      return Left("Something went wrong");
    }
  }

  @override
  Future<Either> getPublicPlaylists() async {
    List<Playlist> publicPlaylists = [];

    try {
      var playlists =
          await FirebaseFirestore.instance
              .collection("Playlists")
              .where("privacy", isEqualTo: "PUBLIC")
              .get();

      for (var element in playlists.docs) {
        var playlistModel = PlaylistModel.fromJson(element.data());
        publicPlaylists.add(
          Playlist(
            playlistModel.name ?? "",
            playlistModel.image ?? "",
            element.id,
          ),
        );
      }

      return Right(publicPlaylists);
    } on FirebaseException catch (e) {
      return Left("Something went wrong $e");
    }
  }

  @override
  Future<Either> createNewPlaylist(String name) async {
    try {
      var instance = FirebaseFirestore.instance.collection("Playlists");

      await instance.add({
        "name": name,
        "privacy": "PRIVATE",
        "added_by": FirebaseAuth.instance.currentUser?.uid ?? "",
        "creation_date": DateTime.now().millisecondsSinceEpoch,
      });

      return Right("");
    } on FirebaseException catch (e) {
      return Left("Something went wrong $e");
    }
  }

  @override
  Future<Either> addSongToPlaylist(
    String playlistId,
    String songID,
    bool add,
  ) async {
    try {
      var instance = FirebaseFirestore.instance
          .collection("Playlists")
          .doc(playlistId)
          .collection("songs");

      if (add) {
        debugPrint("ADD $playlistId $songID");
      } else {
        debugPrint("REMOVE $playlistId $songID");
      }

      if (add) {
        await instance.add({"songId": songID});
        return Right("Song Added");
      } else {
        var snap = await instance.where("songId", isEqualTo: songID).get();

        if (snap.docs.isNotEmpty) {
          await snap.docs[0].reference.delete();
          return Right("Song Removed");
        } else {
          return Left("Song Not Found");
        }
      }
    } on FirebaseException catch (e) {
      return Left("Something went wrong $e");
    }
  }

  @override
  Stream<List<Playlist>> getMyPlaylists() {
    var instance = FirebaseFirestore.instance
        .collection("Playlists")
        .where(
          "added_by",
          isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "",
        );

    return instance.snapshots().asyncMap((snapshot) async {
      final futures =
          snapshot.docs.map((doc) async {
            final playlistId = doc.id;
            final name = doc.data()['name'] ?? '';

            // Get songs for each playlist
            final songsSnap = await doc.reference.collection('songs').get();

            final songs =
                songsSnap.docs.map((songDoc) {
                  return AddSong(songDoc['songId'], "", false);
                }).toList();

            return Playlist(name, "", doc.id, songs: songs);
          }).toList();

      return await Future.wait(futures);
    });
  }
}
