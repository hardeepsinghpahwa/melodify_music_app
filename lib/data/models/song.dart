import 'dart:convert';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  String? title;
  String? artist;
  String? duration;
  String? image;
  String? link;

  SongModel({
    this.title,
    this.artist,
    this.duration,
    this.image,
    this.link
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    title: json["title"],
    artist: json["artist"],
    duration: json["duration"],
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "artist": artist,
    "duration": duration,
    "image": image,
    "link": link,
  };
}
