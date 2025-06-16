import 'dart:convert';

PlaylistModel playlistModelFromJson(String str) => PlaylistModel.fromJson(json.decode(str));

String playlistModelToJson(PlaylistModel data) => json.encode(data.toJson());

class PlaylistModel {
  String? name;
  String? image;

  PlaylistModel({
    this.name,
    this.image,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
