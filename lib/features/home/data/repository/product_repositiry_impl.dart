import 'package:dartz/dartz.dart';
import 'package:logiology/core/errors/failure.dart';
import 'package:logiology/features/home/data/api/product_api.dart';
import 'package:logiology/features/home/data/models/product_model.dart';
import 'package:logiology/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(int limit, int skip) async {
    try {
      final response = await apiService.getProducts(limit, skip);
      return right(response.products);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}