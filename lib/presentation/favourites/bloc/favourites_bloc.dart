import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/song/song.dart';

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
  }
}
