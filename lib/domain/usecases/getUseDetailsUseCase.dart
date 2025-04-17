import 'package:dartz/dartz.dart';
import 'package:music_app/core/useCases/usecase.dart';
import 'package:music_app/domain/repositories/auth.dart';

import '../../services.dart';

class GetUserDetailsUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
    return sl<AuthRepository>().getUserDetails();
  }

}