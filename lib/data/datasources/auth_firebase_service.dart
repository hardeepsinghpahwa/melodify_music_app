import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/data/models/createUserReq.dart';
import 'package:music_app/data/models/signInReq.dart';
import 'package:music_app/domain/entities/auth/user.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';
import '../../services.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest request);

  Future<Either> signIn(SignInReq req);

  Future<Either> getUserDetails();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SignInReq req) async {
    try {
      sl<LoadingBloc>().add(LoadingStartEvent());

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: req.email ?? "",
        password: req.password ?? "",
      );

      sl<LoadingBloc>().add(LoadingStopEvent());
      return Right("Sign In Success");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'invalid-email') {
        message = "This email is not registered";
      } else if (e.code == 'invalid-credential') {
        message = "Incorrect Credentials";
      }
      sl<LoadingBloc>().add(LoadingStopEvent());
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest request) async {
    try {
      sl<LoadingBloc>().add(LoadingStartEvent());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email ?? "",
        password: request.password ?? "",
      );

      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({
              "name": request.fullName,
              "password": request.password,
              "email": request.email,
            });
      }

      sl<LoadingBloc>().add(LoadingStopEvent());
      return Right("Sign Up Success");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "Please use a strong password";
      } else if (e.code == 'email-already-in-use') {
        message = "Email already in use";
      }
      sl<LoadingBloc>().add(LoadingStopEvent());
      return Left(message);
    }
  }

  @override
  Future<Either> getUserDetails() async {
    try {
      var data =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .get();

      UserEntity entity = UserEntity.fromFirestore(data.data()!);

      return Right(entity);
    } on FirebaseException catch (e) {
      return Left("Error");
    }
  }
}
