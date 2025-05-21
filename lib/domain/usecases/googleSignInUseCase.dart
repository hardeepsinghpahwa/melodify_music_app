import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/domain/repositories/auth.dart';

import '../../services.dart';

class GoogleSignUpUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) {
    return sl<AuthRepository>().signInWithGoogle();
  }
}
