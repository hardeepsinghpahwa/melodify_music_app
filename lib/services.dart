
import 'package:get_it/get_it.dart';
import 'package:music_app/data/datasources/auth_firebase_service.dart';
import 'package:music_app/data/repository/auth_repository_impl.dart';
import 'package:music_app/domain/repositories/auth.dart';
import 'package:music_app/domain/usecases/signInUseCase.dart';
import 'package:music_app/domain/usecases/signUpUseCase.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';

final sl=GetIt.instance;

Future<void> initDependencies() async{

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<LoadingBloc>(LoadingBloc());


}