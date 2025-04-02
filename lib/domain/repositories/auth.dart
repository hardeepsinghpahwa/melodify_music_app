import 'package:dartz/dartz.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/data/models/signInReq.dart';

abstract class AuthRepository{

  Future<Either> signUp(CreateUserRequest req);

  Future<Either> signIn(SignInReq req);
}