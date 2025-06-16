import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';

import '../../services.dart';
import '../repositories/songRepo.dart';

class GetPublicPlaylistUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<SongRepository>().getPublicPlaylists();
  }
}
