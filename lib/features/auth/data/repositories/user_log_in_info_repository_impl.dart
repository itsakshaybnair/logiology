import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/features/auth/data/data_source/user_log_in_info_local_data_source.dart';
import 'package:logiology/features/auth/domain/repository/user_log_in_info_repository.dart';
import 'package:logiology/features/auth/domain/usecases/user_login_info_usecase.dart';

class UserLogInInfoRepositoryImpl implements UserLogInInfoRepository {
  final UserLogInInfoLocalDataSource localDataSource;

  UserLogInInfoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Success>> getUserData() async {
    try {
      await localDataSource.getUserData();
      return Right(Success());
    } catch (e) {
      return Left(Failure(
        message: 'Error getting user data: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, Success>> setUserinfo(
      {String? dP, String? name, String? password, bool? isLoggedIn}) async {
    try {
      await localDataSource.setUserData(dP, name, password, isLoggedIn);
      return Right(Success());
    } catch (e) {
      return Left(Failure(
        message: 'Error setting user data: $e',
      ));
    }
  }
}
