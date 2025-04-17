import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/features/product/data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts(int limit, int skip);
}
