import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class SearchSongUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<SongRepository>().searchSong(params!);
  }
}
