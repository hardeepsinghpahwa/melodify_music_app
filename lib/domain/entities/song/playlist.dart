import 'package:music_app/domain/entities/song/addSong.dart';

class Playlist {
  final String name;
  final String image;
  final String id;
  final List<AddSong>? songs;

  Playlist(this.name, this.image, this.id, {this.songs});
}
