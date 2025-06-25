import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/usecases/searchSongUseCase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/song/song.dart';
import '../../../services.dart';

part 'explore_event.dart';

part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreState()) {
    on<RecentSearchesEvent>((event, emit) {
      List<String> result =
          (sl<SharedPreferences>().getStringList("searches")) ?? [];
      debugPrint("RECENT RESULT $result");

      emit(state.copyWith(recentSearches: result.reversed.toList()));
    });

    on<ChangeSearchFocusEvent>((event, emit) {
      emit(state.copyWith(searchFocus: event.focusValue));
    });

    on<RemoveRecentSearchEvent>((event, emit) {
      List<String> result =
          (sl<SharedPreferences>().getStringList("searches")) ?? [];

      if (result.contains(event.value)) {
        result.remove(event.value);
      }
      sl<SharedPreferences>().setStringList("searches", result);

      emit(state.copyWith(recentSearches: result.reversed.toList()));
    });

    on<SearchEvent>((event, emit) async {
      emit(state.copyWith(loading: true,searchFocus: false));

      try {
        var data = await sl<SearchSongUseCase>().call(params: event.searchText);
        data.fold(
          (ifLeft) {
            emit(state.copyWith(loading: false));
          },
          (ifRight) {
            if ((ifRight as List<SongEntity>).isNotEmpty) {
              List<String> recentSearches =
                  (sl<SharedPreferences>().getStringList("searches")) ?? [];

              if (recentSearches.contains(event.searchText)) {
                recentSearches.remove(event.searchText);
              }
              recentSearches.add(event.searchText);

              debugPrint("RECENT SEARCHES $recentSearches");
              sl<SharedPreferences>().setStringList("searches", recentSearches);
              add(RecentSearchesEvent());
            }
            emit(state.copyWith(filteredSongs: ifRight, loading: false));
          },
        );
      } on Exception catch (e) {
        emit(state.copyWith(loading: false));
        debugPrint("ERRRRRR $e");
      }
    });
  }
}
