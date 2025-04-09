import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class TopSongsUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
    return sl<SongRepository>().getTopSongs();
  }

}