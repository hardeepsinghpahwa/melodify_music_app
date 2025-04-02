import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial()) {

    on<LoadingStartEvent>((event, emit) {
      emit(LoadingProgressState());
    });

    on<LoadingStopEvent>((event, emit) {
      emit(LoadingInitial());
    });

  }
}
