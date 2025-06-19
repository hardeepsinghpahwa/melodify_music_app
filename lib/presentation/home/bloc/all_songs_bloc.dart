import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/song/addSong.dart';
import 'package:music_app/domain/entities/song/playlist.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/addSongToPlaylistUseCase.dart';
import 'package:music_app/domain/usecases/getPublicPlaylistsUseCase.dart';
import 'package:music_app/domain/usecases/getTopSongsUseCase.dart';

import '../../../domain/usecases/createNewPlaylistUseCase.dart';
import '../../../domain/usecases/geAllSongsUseCase.dart';
import '../../../domain/usecases/getMyPlaylistsUseCase.dart';
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

    on<MyPlaylistsEvent>((event, emit) async {
      var data = await sl<GetMyPlaylistsUseCase>().call();

      data.listen((data) {
        add(UpdateMyPlaylistsEvent(data));
      });
    });

    on<UpdateMyPlaylistsEvent>((event, emit) async {
      emit(state.copyWith(myPlaylists: event.playlists));
    });

    on<CreateNewPlaylistEvent>((event, emit) async {
      emit(state.copyWith(dialogLoading: true));
      final result = await sl<CreateNewPlaylistUseCase>().call(
        params: event.name,
      );

      result.fold(
        (ifLeft) {
          emit(
            state.copyWith(
              error: "Something went wrong",
              dialogLoading: false,
              backPress: true,
            ),
          );
        },
        (ifRight) {
          emit(
            state.copyWith(
              msg: "New Playlist Created",
              dialogLoading: false,
              backPress: true,
            ),
          );
        },
      );
    });

    on<AddSongToPlaylistEvent>((event, emit) async {
      var loaders = state.playlistLoader ?? [];
      loaders.add(event.playlistId);

      emit(state.copyWith(playlistLoader: loaders));

      final result = await sl<AddSongToPlaylistUseCase>().call(
        params: AddSong(event.songId, event.playlistId, event.add),
      );

      result.fold(
        (ifLeft) {
          loaders.remove(event.playlistId);
          emit(
            state.copyWith(
              error: "Something went wrong",
              dialogLoading: false,
              playlistLoader: loaders,
            ),
          );
        },
        (ifRight) async {
          loaders.remove(event.playlistId);
          emit(
            state.copyWith(
              msg: ifRight,
              dialogLoading: false,
              playlistLoader: loaders,
            ),
          );
          emit(state.copyWith(msg: ""));
          add(MyPlaylistsEvent());
        },
      );
    });
  }
}
