import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/features/product/data/models/product_model.dart';
import 'package:logiology/features/product/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductModel>>> call(int limit, int skip) {
    return repository.getProducts(limit, skip);
  }
}