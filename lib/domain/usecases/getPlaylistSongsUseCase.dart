import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';

import '../../services.dart';
import '../repositories/songRepo.dart';

class GetPlaylistSongsUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<SongRepository>().getPlaylistSongs(params ?? "");
  }
}
