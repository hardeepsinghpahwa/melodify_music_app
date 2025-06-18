import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/domain/repositories/auth.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class CreateNewPlaylistUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<SongRepository>().createNewPlaylist(params!);
  }
}
