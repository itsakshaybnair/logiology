import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logiology/features/home/data/api/product_api.dart';
import 'package:logiology/features/home/data/repository/product_repositiry_impl.dart';
import 'package:logiology/features/home/domain/repositories/product_repository.dart';
import 'package:logiology/features/home/domain/use_cases/get_products_usecase.dart';


final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt..registerLazySingleton<Dio>(() => Dio())

 .. registerLazySingleton<ProductApi>(
      () => ProductApi(getIt<Dio>()))

  ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt<ProductApi>()))

  ..registerLazySingleton(() => GetProductsUseCase(getIt()));
}
