import 'package:dartz/dartz.dart';
import 'package:music_app/data/datasources/auth_firebase_service.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/data/models/signInReq.dart';
import 'package:music_app/domain/repositories/auth.dart';

import '../../services.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SignInReq req) async {
    return await sl<AuthFirebaseService>().signIn(req);
  }

  @override
  Future<Either> signUp(CreateUserRequest req) async {
    return await sl<AuthFirebaseService>().signUp(req);
  }
}
