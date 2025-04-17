import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logiology/features/auth/data/data_source/user_log_in_info_local_data_source.dart';
import 'package:logiology/features/auth/data/repositories/user_log_in_info_repository_impl.dart';
import 'package:logiology/features/auth/domain/repository/user_log_in_info_repository.dart';
import 'package:logiology/features/auth/domain/usecases/set_user_logged_in_usecase.dart';
import 'package:logiology/features/product/data/api/product_api.dart';
import 'package:logiology/features/product/data/repository/product_repositiry_impl.dart';
import 'package:logiology/features/product/domain/repositories/product_repository.dart';
import 'package:logiology/features/product/domain/use_cases/filter_products_usecase.dart';
import 'package:logiology/features/product/domain/use_cases/get_products_usecase.dart';
import 'package:logiology/features/product/domain/use_cases/search_products_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';





final getIt = GetIt.instance;

Future<void> setUpServiceLocator() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt
    ..registerLazySingleton<Dio>(() => Dio())
    ..registerLazySingleton<ProductApi>(() => ProductApi(getIt()))
    ..registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(getIt()))
    ..registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(getIt()))
    ..registerLazySingleton<FilterProductsUseCase>(() => FilterProductsUseCase())
    ..registerLazySingleton<SearchProductsUseCase>(() => SearchProductsUseCase())

    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)

    ..registerLazySingleton<UserLogInInfoLocalDataSource>(
      () => UserLogInInfoLocalDataSourceImpl(getIt())
    )

    ..registerLazySingleton<UserLogInInfoRepository>(
      () => UserLogInInfoRepositoryImpl(getIt())
    )

    ..registerLazySingleton<SetUserLoggedInUsecase>(
      () => SetUserLoggedInUsecase(getIt())
    );

 
}
