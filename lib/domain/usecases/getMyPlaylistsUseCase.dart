import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/repositories/songRepo.dart';

import '../../services.dart';
import '../entities/song/playlist.dart';

class GetMyPlaylistsUseCase extends UseCase<Stream<List<Playlist>>, dynamic> {
  @override
  Future<Stream<List<Playlist>>> call({void params}) async {
    return sl<SongRepository>().getMyPlaylists();
  }
}
