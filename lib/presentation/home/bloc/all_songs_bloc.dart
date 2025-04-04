import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/song/song.dart';

import '../../../domain/usecases/geAllSongsUseCase.dart';
import '../../../services.dart';

part 'all_songs_event.dart';

part 'all_songs_state.dart';

class AllSongsBloc extends Bloc<AllSongsEvent, AllSongsState> {
  AllSongsBloc() : super(AllSongsInitial()) {
    on<AllSongsLoadingEvent>((event, emit) async {
      emit(AllSongsLoading());
      final data = await sl<GetAllSongsUseCase>().call();

      data.fold(
        (ifLeft) {
          emit(AllSongsLoadingFailed(error: "Something went wrong"));
        },
        (ifRight) {
          emit(AllSongsLoaded(songs: ifRight));
        },
      );
    });
  }
}
