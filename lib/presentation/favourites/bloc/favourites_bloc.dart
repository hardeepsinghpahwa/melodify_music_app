import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/song/playlist.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/getMyPlaylistsUseCase.dart';

import '../../../domain/usecases/createNewPlaylistUseCase.dart';
import '../../../domain/usecases/getFavouritesUseCase.dart';
import '../../../services.dart';

part 'favourites_event.dart';

part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesState()) {
    on<FavouritesEvent>((event, emit) {});

    on<GetAllFavouritesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      var data = await sl<GetAllFavouriteSongs>().call();

      data.fold(
        (ifLeft) {
          emit(state.copyWith(isLoading: false, songFavourites: []));
        },
        (ifRight) {
          emit(state.copyWith(isLoading: false, songFavourites: ifRight));
        },
      );
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


    on<GetMyPlaylistsEvent>((event, emit) async {
      var data = await sl<GetMyPlaylistsUseCase>().call();

      data.listen((data) {
        add(UpdateMyPlaylistsEvent(data));
      });
    });

    on<UpdateMyPlaylistsEvent>((event, emit) async {
      emit(state.copyWith(myPlaylists: event.playlists));
    });

    on<ResetEvents>((event, emit) async {
      emit(state.copyWith(dialogLoading: false,backPress: false,msg: "",error: ""));
    });

  }
}
