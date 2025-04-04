import 'dart:convert';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  String? title;
  String? artist;
  String? duration;
  String? image;

  SongModel({
    this.title,
    this.artist,
    this.duration,
    this.image,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    title: json["title"],
    artist: json["artist"],
    duration: json["duration"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "artist": artist,
    "duration": duration,
    "image": image,
  };
}
