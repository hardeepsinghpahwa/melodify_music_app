import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/domain/usecases/checkFavouriteUseCase.dart';
import 'package:music_app/domain/usecases/favouriteUseCase.dart';
import '../../../../domain/entities/song/favourite.dart';
import '../../../../services.dart';

part 'player_position_event.dart';

part 'player_position_state.dart';

class PlayerPositionBloc extends Bloc<PlayerEvent, PlayerCurrentState> {
  PlayerPositionBloc() : super(PlayerCurrentState()) {
    on<PlayerPositionChangeEvent>((event, emit) {
      emit(state.copyWith(position: event.position));
    });

    on<PlayerDurationChangeEvent>((event, emit) {
      emit(state.copyWith(duration: event.duration));
    });

    on<PlayerPlayChangeEvent>((event, emit) {
      emit(state.copyWith(isPlaying: event.playing));
    });

    on<ChangeSongEvent>((event, emit) {
      emit(
        state.copyWith(favourite: false,currentSong: event.songs[event.currentIndex], position: 0, isPlaying: true,songs: event.songs,currentIndex: event.currentIndex),
      );
    });

    on<FavouriteEvent>((event, emit) async {
      var data = await sl<FavouriteUseCase>().call(
        params: Favourite(event.songId, event.favourite),
      );

      data.fold(
        (ifLeft) {
          //emit(state.copyWith(error: "Something went wrong"));
        },
        (ifRight) {
          // if(event.favourite) {
          //   emit(state.copyWith(success: "Favourite Added"));
          // }else{
          //   emit(state.copyWith(success: "Favourite Removed"));
          // }
          emit(state.copyWith(favourite: event.favourite));
          //emit(state.copyWith(success: null));
        },
      );
    });

    on<CheckFavouriteEvent>((event, emit) async {
      emit(state.copyWith(favourite: false));
      var data = await sl<CheckFavouriteUseCase>().call(params: event.songId);

      data.fold((ifLeft) {}, (ifRight) {
        if (ifRight) {
          emit(state.copyWith(favourite: true));
        } else {
          emit(state.copyWith(favourite: false));
        }
      });
    });
  }
}
