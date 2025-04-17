import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/domain/entities/auth/user.dart';
import 'package:music_app/domain/usecases/getUseDetailsUseCase.dart';

import '../../../services.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      emit(state.copyWith(loader: true));

      var data = await sl<GetUserDetailsUseCase>().call();

      data.fold((ifLeft){

      }, (ifRight){
        emit(state.copyWith(entity: ifRight,loader: false));
      });
    });
  }
}
