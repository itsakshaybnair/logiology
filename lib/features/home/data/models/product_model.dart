import 'package:json_annotation/json_annotation.dart';
import 'package:logiology/features/home/domain/entities/product_entity.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.thumbnail, 
    required super.category,
     required super.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}


@JsonSerializable()
class ProductModelResponse {
  final List<ProductModel> products;

  ProductModelResponse({required this.products});

  factory ProductModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelResponseToJson(this);
}