import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';

abstract interface class Usecase<SuccessType,Params> {
  Future<Either<Failure,SuccessType>> call(Params params );
}

class NoParams{
  
}