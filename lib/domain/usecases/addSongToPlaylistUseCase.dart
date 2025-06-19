import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/entities/song/addSong.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class AddSongToPlaylistUseCase extends UseCase<Either, AddSong> {
  @override
  Future<Either> call({AddSong? params}) {
    return sl<SongRepository>().addSongToPlaylist(
      params?.playlistId ?? "",
      params?.songId ?? "",
      params?.add ?? false,
    );
  }
}
