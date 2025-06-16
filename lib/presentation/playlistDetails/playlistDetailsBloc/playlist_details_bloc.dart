import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/getPlaylistSongsUseCase.dart';

import '../../../services.dart';

part 'playlist_details_event.dart';

part 'playlist_details_state.dart';

class PlaylistDetailsBloc
    extends Bloc<PlaylistDetailsEvent, PlaylistDetailsState> {
  PlaylistDetailsBloc() : super(PlaylistDetailsState()) {
    on<LoadPlaylistSongs>((event, emit) async {
      emit(state.copyWith(loading: true));
      final data = await sl<GetPlaylistSongsUseCase>().call(params: event.playlistId);

      data.fold(
        (ifLeft) {
          emit(state.copyWith(error: "Something went wrong", loading: false));
        },
        (ifRight) {
          emit(state.copyWith(songs: ifRight, loading: false));
        },
      );
    });
  }
}
