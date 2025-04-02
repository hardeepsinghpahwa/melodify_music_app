import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/data/datasources/auth_firebase_service.dart';
import 'package:music_app/data/models/signInReq.dart';
import 'package:music_app/domain/repositories/auth.dart';

import '../../services.dart';

class SignInUseCase extends UseCase<Either,SignInReq>{
  @override
  Future<Either> call({SignInReq? params}) {
    return sl<AuthRepository>().signIn(params!);
  }


}