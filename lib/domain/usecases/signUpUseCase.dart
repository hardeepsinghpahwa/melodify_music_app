import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/domain/repositories/auth.dart';

import '../../services.dart';

class SignUpUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
}
