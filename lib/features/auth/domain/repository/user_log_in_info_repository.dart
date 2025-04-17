import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/features/auth/domain/usecases/user_login_info_usecase.dart';

abstract class UserLogInInfoRepository {
 

 Future<Either<Failure, Success>> setUserinfo({
     String? dP,
     String? name,
     String? password,
     bool? isLoggedIn,
  });



  Future<Either<Failure, Success>> getUserData();
}
