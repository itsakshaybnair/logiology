import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/core/usecase/usecase.dart';
import 'package:logiology/features/auth/domain/repository/user_log_in_info_repository.dart';
import 'package:logiology/features/auth/domain/usecases/user_login_info_usecase.dart';

class SetUserLoggedInUsecase implements Usecase<Success, UserInfoParams> {
  final UserLogInInfoRepository uerLogInInfoRepository;

  SetUserLoggedInUsecase(this.uerLogInInfoRepository);

  @override
  Future<Either<Failure, Success>> call(final  params) async {
    return await uerLogInInfoRepository.setUserinfo(
        dP: params.dP,
        name: params.name,
        password: params.password,
        isLoggedIn: params.isLoggedIn);
  }
}

class UserInfoParams {
  final String? dP;
  final String? name;
  final String? password;
  final bool? isLoggedIn;

  UserInfoParams( {
     this.dP,
     this.name,
     this.password,
     this.isLoggedIn,
  });
}
