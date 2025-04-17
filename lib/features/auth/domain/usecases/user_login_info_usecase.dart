import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/core/usecase/usecase.dart';
import 'package:logiology/features/auth/domain/repository/user_log_in_info_repository.dart';

class UerLogInInfoUsecase implements Usecase<Success, NoParams> {
  final UserLogInInfoRepository uerLogInInfoRepository;

  UerLogInInfoUsecase(this.uerLogInInfoRepository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return await uerLogInInfoRepository.getUserData();
  }
}




class Success {}
