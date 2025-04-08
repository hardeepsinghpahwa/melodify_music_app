import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/entities/song/favourite.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';

class FavouriteUseCase extends UseCase<Either, Favourite> {
  @override
  Future<Either> call({Favourite? params}) {
    return sl<SongRepository>().favouriteSong(
      params?.favourite ?? false,
      params?.id ?? "",
    );
  }
}
