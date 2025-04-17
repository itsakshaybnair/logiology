import 'package:dio/dio.dart';
import 'package:logiology/features/home/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';
part 'product_api.g.dart';


@RestApi(baseUrl: "https://dummyjson.com")
abstract class ProductApi {
  factory ProductApi(Dio dio, {String baseUrl}) = _ProductApi;

  @GET("/products")
  Future<ProductModelResponse> getProducts(
   @Query("limit") int limit,
  @Query("skip") int skip,
  );
}