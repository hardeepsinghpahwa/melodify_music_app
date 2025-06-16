import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/song/playlist.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/getPublicPlaylistsUseCase.dart';
import 'package:music_app/domain/usecases/getTopSongsUseCase.dart';

import '../../../domain/usecases/geAllSongsUseCase.dart';
import '../../../services.dart';

part 'all_songs_event.dart';

part 'all_songs_state.dart';

class AllSongsBloc extends Bloc<SongsEvent, AllSongsState> {
  AllSongsBloc() : super(AllSongsState()) {
    on<AllSongsLoadingEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      final data = await sl<GetAllSongsUseCase>().call();

      data.fold(
        (ifLeft) {
          emit(state.copyWith(error: "Something went wrong", loading: false));
        },
        (ifRight) {
          emit(state.copyWith(allSongs: ifRight, loading: false));
        },
      );
    });

    on<Top10SongsLoadingEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      final data = await sl<TopSongsUseCase>().call();

      data.fold(
        (ifLeft) {
          emit(state.copyWith(error: "Something went wrong", loading: false));
        },
        (ifRight) {
          emit(state.copyWith(topSongs: ifRight, loading: false));
        },
      );
    });

    on<PublicPlaylistsEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      final data = await sl<GetPublicPlaylistUseCase>().call();

      data.fold(
            (ifLeft) {
          emit(state.copyWith(error: "Something went wrong", loading: false));
        },
            (ifRight) {
          emit(state.copyWith(publicPlaylists: ifRight, loading: false));
        },
      );
    });
  }
}
