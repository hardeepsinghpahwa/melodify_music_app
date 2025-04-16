import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/usecases/searchSongUseCase.dart';

import '../../../domain/entities/song/song.dart';
import '../../../services.dart';

part 'explore_event.dart';

part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreState()) {
    on<ExploreEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchEvent>((event, emit) async {

      emit(state.copyWith(loading: true));

      var data= await sl<SearchSongUseCase>().call(params: event.searchText);

      data.fold((ifLeft){

      }, (ifRight){
        emit(state.copyWith(filteredSongs: ifRight));
      });

      emit(state.copyWith(loading: false));

    });
  }
}
